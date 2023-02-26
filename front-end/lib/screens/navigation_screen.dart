import 'package:flutter/material.dart';

import '../classes/user_data.dart';
import '../themes/roomie_color.dart';
import 'navigated_screens/deck_screens/deck_screen.dart';
import 'navigated_screens/my_chatting_screen.dart';
import 'navigated_screens/my_profile_screen.dart';
import 'navigated_screens/settings_screen.dart';

class NavigationScreen extends StatefulWidget {
  late UserData userData;
  NavigationScreen({
    super.key,
    required this.userData,
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
        backgroundColor: RoomieColor.appBar,
        elevation: 0,
      ),
      backgroundColor: RoomieColor.background,
      body: Center(
        child: ListView(
          controller: scrollController,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            const DeckScreen(),
            MyProfileScreen(
              userData: widget.userData,
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
            backgroundColor: RoomieColor.navigationBar,
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
            selectedItemColor: RoomieColor.selectedItem,
            unselectedItemColor: RoomieColor.unselectedItem,
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
