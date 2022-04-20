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
          colors: [const Color(0xd09de385), const Color(0xffd9e57f)],
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
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 30, left: 15, top: 20),
                    height: 200,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: const AssetImage(''),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(12.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xffe171c8),
                                          offset: Offset(0, 3),
                                          blurRadius: 43,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      
                                      child: CircleAvatar(
                                        radius: 32,
                                        
                                        foregroundImage:
                                            NetworkImage(myAccount.imagePath),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        myAccount.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '@${myAccount.userId}',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  )
                                ],
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
                                      myAccount = Authentication.myAccount!;
                                    });
                                  }
                                },
                                child: Text('編集'),
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(myAccount.selfIntroduction)
                        ]),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.blue, width: 3))),
                    child: Text('投稿',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
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
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          Post post = snapshot.data![index];
                                          return Container(
                                            decoration: BoxDecoration(
                                                border: index == 0
                                                    ? Border(
                                                        top: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0),
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0))
                                                    : Border(
                                                        bottom: BorderSide(
                                                            color: Colors.grey,
                                                            width: 0),
                                                      )),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 15),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 22,
                                                  foregroundImage: NetworkImage(
                                                      myAccount.imagePath),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets
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
                                                                        color: Colors
                                                                            .grey),
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
                          }))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
