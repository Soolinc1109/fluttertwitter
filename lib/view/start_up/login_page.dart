import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/screen.dart';
import 'package:fluttertwitter/view/start_up/create_account_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfddefdc8),
        border: Border.all(width: 1.0, color: const Color(0xff707070)),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(children: [
              SizedBox(height: 110),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image(
                  image: AssetImage(
                      '/Users/uedaakira/fluttertwitter/images/olive.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  '基本情報を登録',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: 'メールアドレス',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: 300,
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                        hintText: 'パスワード',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(text: 'アカウントを作成していない方は'),
                    TextSpan(
                        text: 'こちら',
                        style: TextStyle(
                          color: Color.fromARGB(255, 71, 240, 158),
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateAccountPage()),
                            );
                          })
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              //ボタンを押してログイン
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 71, 240, 158),
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    var result = await Authentication.emailSignIn(
                        email: emailController.text, pass: passController.text);
                    if (result is UserCredential) {
                      if (result.user!.emailVerified == true) {
                        var _result =
                            await UserFirestore.getUser(result.user!.uid);
                        if (_result = true) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Screen()));
                        }
                      } else {
                        print('メール認証できていません');
                      }
                    }
                  },
                  child: Text('emailでログイン')),
            ]),
          ),
        ),
      ),
    );
  }
}
