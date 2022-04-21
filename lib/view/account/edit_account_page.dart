import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/utils/function_utils.dart';
import 'package:fluttertwitter/utils/widget_utils.dart';
import 'package:fluttertwitter/view/start_up/login_page.dart';
import 'package:image_picker/image_picker.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({Key? key}) : super(key: key);

  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  Account myAccount = Authentication.myAccount!; //初期段階で編集画面に内容を追加する
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController selfIntroductionController = TextEditingController();
  TextEditingController universalController = TextEditingController();
  TextEditingController highschoolController = TextEditingController();
  TextEditingController junior_high_schoolController = TextEditingController();
  TextEditingController sanukibenController = TextEditingController();
  TextEditingController kagawarekiController = TextEditingController();
  TextEditingController zokuseiController = TextEditingController();
  TextEditingController likemovieController = TextEditingController();
  TextEditingController likefoodController = TextEditingController();
  TextEditingController hobbyController = TextEditingController();

  File? image;

  ImageProvider getImage() {
    if (image == null) {
      return NetworkImage(myAccount.imagePath);
    } else {
      return FileImage(image!);
    }
  }

  @override //初期段階で編集画面に内容を追加する
  void initState() {
    super.initState();
    nameController = TextEditingController(text: myAccount.name);
    userIdController = TextEditingController(text: myAccount.userId);
    selfIntroductionController =
        TextEditingController(text: myAccount.selfIntroduction);
    universalController = TextEditingController(text: myAccount.universal);
    highschoolController = TextEditingController(text: myAccount.highschool);
    junior_high_schoolController =
        TextEditingController(text: myAccount.junior_high_school);
    sanukibenController = TextEditingController(text: myAccount.sanukiben);
    kagawarekiController = TextEditingController(text: myAccount.kagawareki);
    zokuseiController = TextEditingController(text: myAccount.zokusei);
    likemovieController = TextEditingController(text: myAccount.likemovie);
    likefoodController = TextEditingController(text: myAccount.likefood);
    hobbyController = TextEditingController(text: myAccount.hobby);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color.fromARGB(208, 145, 255, 108),
            Color.fromARGB(255, 237, 255, 100)
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0x90afe383),
            offset: Offset(6, 3),
            blurRadius: 18,
          ),
        ],
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: WidgetUtils.createAppBar('プロフィール編集'),
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
                      foregroundImage: getImage(),
                      radius: 40,
                      child: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: '名前'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: userIdController,
                        decoration: InputDecoration(hintText: 'ユーザーID'),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: selfIntroductionController,
                      decoration: InputDecoration(hintText: '自己紹介'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: universalController,
                        decoration: InputDecoration(hintText: '大学名'),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: highschoolController,
                      decoration: InputDecoration(hintText: '高校名'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: junior_high_schoolController,
                        decoration: InputDecoration(hintText: '中学名'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: sanukibenController,
                        decoration: InputDecoration(hintText: '好きな讃岐弁'),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: kagawarekiController,
                      decoration: InputDecoration(hintText: '香川歴'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: zokuseiController,
                        decoration: InputDecoration(hintText: '属性'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: likemovieController,
                        decoration: InputDecoration(hintText: '好きな映画'),
                      ),
                    ),
                  ),
                  Container(
                    width: 300,
                    child: TextField(
                      controller: likefoodController,
                      decoration: InputDecoration(hintText: '好きな食べ物'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      width: 300,
                      child: TextField(
                        controller: hobbyController,
                        decoration: InputDecoration(hintText: '趣味'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  // 情報を更新
                  ElevatedButton(
                      onPressed: () async {
                        if (nameController.text.isNotEmpty &&
                            userIdController.text.isNotEmpty &&
                            selfIntroductionController.text.isNotEmpty &&
                            universalController.text.isNotEmpty &&
                            highschoolController.text.isNotEmpty &&
                            junior_high_schoolController.text.isNotEmpty) {
                          String imagePath = '';
                          if (image == null) {
                            imagePath = myAccount.imagePath;
                          } else {
                            var result = await FunctionUtils.upLoadImage(
                                myAccount.id, image!);
                            imagePath = result;
                          }
                          Account updateAccount = Account(
                              id: myAccount.id,
                              name: nameController.text,
                              userId: userIdController.text,
                              selfIntroduction: selfIntroductionController.text,
                              universal: universalController.text,
                              highschool: highschoolController.text,
                              junior_high_school:
                                  junior_high_schoolController.text,
                              sanukiben: sanukibenController.text,
                              kagawareki: kagawarekiController.text,
                              zokusei: zokuseiController.text,
                              likemovie: likemovieController.text,
                              likefood: likefoodController.text,
                              hobby: hobbyController.text,
                              imagePath: imagePath); // Account

                          Authentication.myAccount = updateAccount;
                          var result =
                              await UserFirestore.updateUser(updateAccount);
                          if (result == true) {
                            Navigator.pop(context, true);
                          }
                        }
                      },
                      child: Text('更新')),
                  SizedBox(height: 30),
                  ElevatedButton(
                      onPressed: () {
                        Authentication.signOut();
                        while (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text('ログアウト'))
                ],
              ),
            ),
          )),
    );
  }
}
