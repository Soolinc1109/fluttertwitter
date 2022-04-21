import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/utils/authentication.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/account/edit_account_page.dart';
import 'package:intl/intl.dart';
import '../../model/account.dart';
import '../../model/post.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Account myAccount = Authentication.myAccount!;

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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                height: 1600,
                decoration: BoxDecoration(
                  color: Color.fromARGB(122, 255, 255, 255),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 25, top: 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            height: 100,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: const AssetImage(''),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromARGB(
                                                      255, 214, 59, 181),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 13,
                                                ),
                                              ],
                                            ),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment(-1.0, 0.0),
                                                  end: Alignment(1.0, 0.0),
                                                  colors: [
                                                    Color.fromARGB(
                                                        208, 245, 136, 255),
                                                    Color.fromARGB(
                                                        255, 237, 100, 255)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          myAccount.imagePath),
                                                      fit: BoxFit.fill,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                              ),
                                            )),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 210,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(35.0),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'instaの\nフォロワー数',
                                                  style: TextStyle(
                                                    fontFamily: 'YuGothic',
                                                    fontSize: 17,
                                                    color:
                                                        const Color(0xff171616),
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.3529411764705883,
                                                  ),
                                                  textHeightBehavior:
                                                      TextHeightBehavior(
                                                          applyHeightToFirstAscent:
                                                              false),
                                                  softWrap: false,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Text(
                                                    '3161',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Apple Braille',
                                                      fontSize: 33,
                                                      color: const Color(
                                                          0xffc4e4b3),
                                                      letterSpacing: -0.722,
                                                      height:
                                                          0.42105263157894735,
                                                      shadows: [
                                                        Shadow(
                                                          color: Color.fromARGB(
                                                              255,
                                                              237,
                                                              255,
                                                              146),
                                                          offset: Offset(0, 3),
                                                          blurRadius: 11,
                                                        )
                                                      ],
                                                    ),
                                                    textHeightBehavior:
                                                        TextHeightBehavior(
                                                            applyHeightToFirstAscent:
                                                                false),
                                                    softWrap: false,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        OutlineButton(
                                          onPressed: () async {
                                            var result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditAccountPage()));
                                            if (result == true) {
                                              setState(() {
                                                myAccount =
                                                    Authentication.myAccount!;
                                              });
                                            }
                                          },
                                          child: Text('編集'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    myAccount.name,
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 130,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(-1.0, 0.0),
                                          end: Alignment(1.0, 0.0),
                                          colors: [
                                            Color.fromARGB(208, 120, 248, 131),
                                            Color.fromARGB(255, 230, 241, 144)
                                          ],
                                          stops: [0.0, 1.0],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(21.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0x90afe383),
                                            offset: Offset(6, 3),
                                            blurRadius: 18,
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          children: [
                                            const Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    top: 8, right: 15),
                                                child: Text(
                                                  '102',
                                                  style: TextStyle(
                                                    fontFamily: 'Apple Braille',
                                                    fontSize: 34,
                                                    color:
                                                        const Color(0xffffffff),
                                                    height: 0.36363636363636365,
                                                    shadows: [
                                                      Shadow(
                                                        color: const Color(
                                                            0xe3ffffff),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 11,
                                                      )
                                                    ],
                                                  ),
                                                  textHeightBehavior:
                                                      TextHeightBehavior(
                                                          applyHeightToFirstAscent:
                                                              false),
                                                  softWrap: false,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '23人の人が\nあなたのまとめを見ました',
                                              style: TextStyle(
                                                fontFamily: 'Apple Braille',
                                                fontSize: 21,
                                                color: const Color(0xffffffff),
                                                height: 1.173913043478261,
                                                shadows: [
                                                  Shadow(
                                                    color:
                                                        const Color(0xe3ffffff),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 11,
                                                  )
                                                ],
                                              ),
                                              textHeightBehavior:
                                                  TextHeightBehavior(
                                                      applyHeightToFirstAscent:
                                                          false),
                                              softWrap: false,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          Container(
                                            alignment: Alignment.bottomRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(18.0),
                                              child: Text(
                                                '23',
                                                style: TextStyle(
                                                  fontFamily: 'Apple Braille',
                                                  fontSize: 44,
                                                  color:
                                                      const Color(0xffffffff),
                                                  height: 0.36363636363636365,
                                                  shadows: [
                                                    Shadow(
                                                      color: const Color(
                                                          0xe3ffffff),
                                                      offset: Offset(0, 3),
                                                      blurRadius: 11,
                                                    )
                                                  ],
                                                ),
                                                textHeightBehavior:
                                                    TextHeightBehavior(
                                                        applyHeightToFirstAscent:
                                                            false),
                                                softWrap: false,
                                              ),
                                            ),
                                            height: 130,
                                            width: 140,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment(0.0, -1.0),
                                                end: Alignment(0.0, 1.0),
                                                colors: [
                                                  Color.fromARGB(
                                                      204, 191, 113, 255),
                                                  Color.fromARGB(
                                                      209, 253, 27, 193)
                                                ],
                                                stops: [0.0, 1.0],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(28.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      const Color(0xffc262cd),
                                                  offset: Offset(0, 3),
                                                  blurRadius: 17,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Container(
                                              alignment: Alignment.bottomRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Text(
                                                  '42',
                                                  style: TextStyle(
                                                    fontFamily: 'Apple Braille',
                                                    fontSize: 47,
                                                    color:
                                                        const Color(0xffffffff),
                                                    height: 0.3617021276595745,
                                                    shadows: [
                                                      Shadow(
                                                        color: const Color(
                                                            0xe3ffffff),
                                                        offset: Offset(0, 3),
                                                        blurRadius: 11,
                                                      )
                                                    ],
                                                  ),
                                                  textHeightBehavior:
                                                      TextHeightBehavior(
                                                          applyHeightToFirstAscent:
                                                              false),
                                                  softWrap: false,
                                                ),
                                              ),
                                              height: 130,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment(0.0, -1.0),
                                                  end: Alignment(0.0, 1.0),
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 0, 237, 254),
                                                    Color.fromARGB(
                                                        255, 93, 161, 255)
                                                  ],
                                                  stops: [0.0, 1.0],
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(28.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xff1bb5fc),
                                                    offset: Offset(0, 3),
                                                    blurRadius: 14,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      const Align(
                                        alignment: Alignment.topRight,
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40),
                                                            child: Text(
                                                              '大学',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 50),
                                                            child: Text(
                                                              '${myAccount.universal}大学',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40),
                                                            child: Text(
                                                              '高校',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 50),
                                                            child: Text(
                                                              '${myAccount.highschool}高校',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 40),
                                                          child: Text(
                                                            '中学',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'YuGothic',
                                                              fontSize: 20,
                                                              color: const Color(
                                                                  0xff171616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 50),
                                                          child: Text(
                                                            '${myAccount.junior_high_school}中学',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'YuGothic',
                                                              fontSize: 20,
                                                              color: const Color(
                                                                  0xff171616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40),
                                                            child: Text(
                                                              '好きな讃岐弁',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 50),
                                                            child: Text(
                                                              '${myAccount.sanukiben}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40),
                                                            child: Text(
                                                              '香川歴',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 50),
                                                            child: Text(
                                                              '${myAccount.kagawareki}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 40),
                                                          child: Text(
                                                            '属性',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'YuGothic',
                                                              fontSize: 20,
                                                              color: const Color(
                                                                  0xff171616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 50),
                                                          child: Text(
                                                            '${myAccount.zokusei}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'YuGothic',
                                                              fontSize: 20,
                                                              color: const Color(
                                                                  0xff171616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 30),
                                                  child: Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40),
                                                            child: Text(
                                                              '好きな映画',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 50),
                                                            child: Text(
                                                              '${myAccount.likemovie}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Container(
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 40),
                                                            child: Text(
                                                              '好きな食べ物',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 50),
                                                            child: Text(
                                                              '${myAccount.likefood}',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'YuGothic',
                                                                fontSize: 20,
                                                                color: const Color(
                                                                    0xff171616),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              softWrap: false,
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 40),
                                                          child: Text(
                                                            '趣味',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'YuGothic',
                                                              fontSize: 20,
                                                              color: const Color(
                                                                  0xff171616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 50),
                                                          child: Text(
                                                            '${myAccount.hobby}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'YuGothic',
                                                              fontSize: 20,
                                                              color: const Color(
                                                                  0xff171616),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            softWrap: false,
                                                          ),
                                                        ),
                                                      ]),
                                                ),
                                              ],
                                            ),
                                            height: 470,
                                            width: 320,
                                            decoration: BoxDecoration(
                                              color: const Color(0x9affffff),
                                              borderRadius:
                                                  BorderRadius.circular(51.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                      const Color(0xbcffffff),
                                                  offset: Offset(6, 3),
                                                  blurRadius: 33,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      width: 3))),
                          child: Text('投稿',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 95, 95, 95),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                            child: Container(
                          height: 500,
                          child: StreamBuilder<QuerySnapshot>(
                              stream: UserFirestore
                                  .users //タイムラインなどのすぐ変わるページの時に使う→stream値が変わるとbuilderが発火する
                                  .doc(myAccount.id)
                                  .collection('my_posts')
                                  .orderBy('created_time', descending: true)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<String> myPostIds = List.generate(
                                      snapshot.data!.docs.length, (index) {
                                    return snapshot.data!.docs[index].id;
                                  });
                                  return FutureBuilder<List<Post>?>(
                                      //一回だけ取ってくる→アカウントページなどのあまり変わらないページの時に使う
                                      future: PostFirestore()
                                          .getPostsFromIds(myPostIds),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: snapshot.data!.length,
                                            itemBuilder: (context, index) {
                                              Post post = snapshot.data![index];
                                              return Container(
                                                decoration: BoxDecoration(
                                                    border: index == 0
                                                        ? Border(
                                                            top: BorderSide(
                                                                color:
                                                                    Colors.grey,
                                                                width: 0),
                                                            bottom: BorderSide(
                                                                color:
                                                                    Colors.grey,
                                                                width: 0))
                                                        : Border(
                                                            bottom: BorderSide(
                                                                color:
                                                                    Colors.grey,
                                                                width: 0),
                                                          )),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 15),
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 22,
                                                      foregroundImage:
                                                          NetworkImage(myAccount
                                                              .imagePath),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 11),
                                                        child: Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        myAccount
                                                                            .name,
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                      Text(
                                                                        '@${myAccount.userId}',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(DateFormat(
                                                                          'M/d/yy')
                                                                      .format(post
                                                                          .createdTime!
                                                                          .toDate()))
                                                                ],
                                                              ),
                                                              Text(post.content)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        } else {
                                          return Container();
                                        }
                                      });
                                } else {
                                  return Container();
                                }
                              }),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
