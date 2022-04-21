import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertwitter/view/account/account_page.dart';
import 'package:fluttertwitter/view/time_line/post_page.dart';
import 'package:fluttertwitter/view/time_line/time_line_page.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;
  List<Widget> pageList = [
    TimeLinePage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.perm_identity_outlined,
              ),
              label: '')
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 71, 240, 158),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPage()),
          );
        },
        child: Icon(
          Icons.chat_bubble_outline,
          color: Color.fromARGB(255, 57, 151, 106),
        ),
      ),
      
    );
  }
}
