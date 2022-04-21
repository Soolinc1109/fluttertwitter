import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/utils/widget_utils.dart';
import 'package:fluttertwitter/view/start_up/check_email_page.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/function_utils.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  File? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfddefdc8),
        border: Border.all(width: 1.0, color: const Color(0xff707070)),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: WidgetUtils.createAppBar('新規登録'),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var result = await FunctionUtils.getImageFromGallery();
                      if (result != null) {
                        setState(() {
                          image = File(result.path);
                        });
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 71, 240, 158),
                      foregroundImage: image == null ? null : FileImage(image!),
                      radius: 40,
                      child: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 22, 126, 75),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: '名前',
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
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: userIdController,
                        decoration: InputDecoration(
                            hintText: 'ユーザーID',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  ),
                  Container(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                  Container(
                    width: 300,
                    child: TextField(
                      controller: selfIntroductionController,
                      decoration: InputDecoration(
                          hintText: '自己紹介',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 71, 240, 158),
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (nameController.text.isNotEmpty &&
                            userIdController.text.isNotEmpty &&
                            selfIntroductionController.text.isNotEmpty &&
                            emailController.text.isNotEmpty &&
                            passController.text.isNotEmpty &&
                            image != null) {
                          var result = await Authentication.signUp(
                              email: emailController.text,
                              pass: passController.text);
                          if (result is UserCredential) {
                            String imagePath = await FunctionUtils.upLoadImage(
                                result.user!.uid, image!);
                            Account newAccount = Account(
                              id: result.user!.uid,
                              name: nameController.text,
                              userId: userIdController.text,
                              selfIntroduction: selfIntroductionController.text,
                              imagePath: imagePath,
                            );
                            var _result =
                                await UserFirestore.setUser(newAccount);
                            if (_result == true) {
                              result.user!.sendEmailVerification();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckEmailPage(
                                          email: emailController.text,
                                          pass: passController.text,
                                        )),
                              );
                            }
                          }
                        }
                      },
                      child: Text('アカウントを作成'))
                ],
              ),
            ),
          )),
    );
  }
}
