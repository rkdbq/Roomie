import 'package:flutter/material.dart';
import 'package:roomie/screens/navigated_screens/my_chatting_screen.dart';
import 'package:roomie/screens/navigated_screens/my_profile_screen.dart';
import 'package:roomie/screens/navigated_screens/settings_screen.dart';

import '../classes/user_data.dart';
import 'navigated_screens/deck_screens/deck_screen.dart';

class NavigationScreen extends StatefulWidget {
  late UserData userData;
  late List<Color> colors;
  NavigationScreen({
    super.key,
    required this.userData,
    required this.colors,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index = 0;

  ScrollController scrollController = ScrollController();
  void animateListView(int index) {
    scrollController.animateTo(
      index * MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 2,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xffeff1f3),
      body: Center(
        child: ListView(
          controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const DeckScreen(),
            MyProfileScreen(
              userData: widget.userData,
              colors: widget.colors,
            ),
            const MyChattingScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 96,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xffffffff),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_document),
                label: '내 프로필',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: '내 채팅',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: '설정',
              ),
            ],
            currentIndex: index,
            selectedItemColor: const Color(0xff000000),
            unselectedItemColor: const Color(0xffa9afb7),
            iconSize: 30,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              setState(
                () {
                  animateListView(value);
                  index = value;
                  print(value);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
