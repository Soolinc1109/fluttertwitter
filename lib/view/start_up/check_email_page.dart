import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/utils/widget_utils.dart';
import 'package:fluttertwitter/view/screen.dart';

class CheckEmailPage extends StatefulWidget {
  final String email;
  final String pass;
  CheckEmailPage({required this.email, required this.pass});

  @override
  _CheckEmailPageState createState() => _CheckEmailPageState();
}

class _CheckEmailPageState extends State<CheckEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetUtils.createAppBar('メールアドレスを確認'),
      body: Column(
        children: [
          Text('登録'),
          ElevatedButton(
              onPressed: () async {
                var result = await Authentication.emailSignIn(
                    email: widget.email, pass: widget.pass);
                print(result);
                try {
                  if (result is UserCredential) {
                    if (result.user!.emailVerified == true) {
                      while (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      await UserFirestore.getUser(result.user!.uid);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Screen()));
                    } else {
                      print('メール認証が終わっていません');
                    }
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: Text('認証完了'))
        ],
      ),
    );
  }
}
