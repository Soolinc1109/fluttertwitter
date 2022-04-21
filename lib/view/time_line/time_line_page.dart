import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertwitter/model/account.dart';
import 'package:fluttertwitter/model/post.dart';
import 'package:fluttertwitter/utils/firestore/posts.dart';
import 'package:fluttertwitter/utils/firestore/users.dart';
import 'package:fluttertwitter/view/time_line/post_page.dart';
import 'package:intl/intl.dart';

class TimeLinePage extends StatefulWidget {
  const TimeLinePage({Key? key}) : super(key: key);

  @override
  _TimeLinePageState createState() => _TimeLinePageState();
}

class _TimeLinePageState extends State<TimeLinePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            Color.fromARGB(208, 162, 255, 132),
            Color.fromARGB(255, 242, 255, 140)
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(144, 198, 255, 148),
            offset: Offset(6, 3),
            blurRadius: 18,
          ),
        ],
      ),
      child: Scaffold(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'タイムライン',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
          ),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          elevation: 2,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: PostFirestore.posts
                .orderBy('created_time', descending: true)
                .snapshots(),
            builder: (context, postSnapshot) {
              if (postSnapshot.hasData) {
                List<String> postAccountIds = [];
                postSnapshot.data!.docs.forEach((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  if (!postAccountIds.contains(data['post_account_id'])) {
                    postAccountIds.add(data['post_account_id']);
                  }
                });
                return FutureBuilder<Map<String, Account>?>(
                    future: UserFirestore.getPostUserMap(postAccountIds),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.hasData &&
                          userSnapshot.connectionState ==
                              ConnectionState.done) {
                        return ListView.builder(
                          itemCount: postSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                postSnapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            Post post = Post(
                                id: postSnapshot.data!.docs[index].id,
                                content: data['content'],
                                postAccountId: data['post_account_id'],
                                createdTime: data['created_time']);
                            Account postAccount =
                                userSnapshot.data![post.postAccountId]!;
                            return Container(
                              decoration: BoxDecoration(
                                  border: index == 0
                                      ? Border(
                                          top: BorderSide(
                                              color: Colors.grey, width: 0),
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0))
                                      : Border(
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0),
                                        )),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 15),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 6,
                                      right: 8,
                                    ),
                                    child: CircleAvatar(
                                      radius: 28,
                                      foregroundImage:
                                          NetworkImage(postAccount.imagePath),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    postAccount.name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 7),
                                                    child: Text(
                                                      '@${postAccount.userId}',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(DateFormat('M/d').format(
                                                  post.createdTime!.toDate()))
                                            ],
                                          ),
                                          Text(post.content)
                                        ],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostPage()),
            );
          },
          child: Icon(Icons.chat_bubble_outline),
        ),
      ),
    );
  }
}
