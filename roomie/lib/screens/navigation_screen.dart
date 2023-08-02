import 'package:flutter/material.dart';
import 'package:roomie/widgets/bottom_navigation_bar.dart';

import '../classes/user_data.dart';
import '../themes/roomie_color.dart';
import 'navigated_screens/deck_screens/deck_screen.dart';
import 'navigated_screens/my_chatting_screen.dart';
import 'navigated_screens/my_profile_screen.dart';
import 'navigated_screens/settings_screen.dart';

class NavigationScreen extends StatefulWidget {
  final UserData userData;
  const NavigationScreen({
    super.key,
    required this.userData,
  });

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int index = 0;
  ScrollController scrollController = ScrollController();

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
            DeckScreen(
              userData: widget.userData,
            ),
            MyProfileScreen(
              userData: widget.userData,
            ),
            const MyChattingScreen(),
            const SettingsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: RoundedBottomNavigationBar(
        index: index,
        onTap: (value) {
          setState(
            () {
              animateListView(value);
              index = value;
            },
          );
        },
      ),
    );
  }

  void animateListView(int index) {
    scrollController.animateTo(
      index * MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
