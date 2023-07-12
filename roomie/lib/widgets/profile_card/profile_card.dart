import 'package:flutter/material.dart';
import 'package:roomie/themes/roomie_color.dart';
import 'package:roomie/widgets/profile_card/profile_button.dart';

import '../../classes/user_data.dart';
import '../../screens/navigated_screens/deck_screens/other_profile_screen.dart';
import 'commonalities.dart';
import 'difference.dart';

class ProfileCard extends StatelessWidget {
  late UserData userData;
  late bool isMine;
  int index;
  ProfileCard({
    super.key,
    required this.userData,
    required this.index,
    this.isMine = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: userData.color,
      ),
      width: 300,
      height: 450,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userData.major,
                  style: TextStyle(
                    fontSize: 30,
                    color: RoomieColor.mainText,
                  ),
                ),
                Text(
                  userData.studentNumber,
                  style: TextStyle(
                    fontSize: 30,
                    color: RoomieColor.mainText,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  userData.name,
                  style: TextStyle(
                    fontSize: 18,
                    color: RoomieColor.mainText,
                  ),
                ),
                Text(
                  ": ${userData.surveyData.answers["etc"]}",
                  style: TextStyle(
                    fontSize: 24,
                    color: RoomieColor.mainText,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Commonalities(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 6),
              child: Difference(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Visibility(
                visible: !isMine,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => print("삭제"),
                      icon: const Icon(
                        Icons.person_remove,
                        color: Color(0xffe3242b),
                      ),
                    ),
                    ProfileButton(
                      backgroundColor: const Color(0xff2832c2),
                      iconData: Icons.description_rounded,
                      labelText: "프로필",
                      onPressed: () {
                        Navigator.push(
                            context, createOtherProfileScreenRoute());
                      },
                    ),
                    ProfileButton(
                      backgroundColor: const Color(0xff028a0f),
                      iconData: Icons.chat_bubble_rounded,
                      labelText: "새 채팅",
                      onPressed: () {
                        print("새 채팅");
                      },
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: isMine,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  userData.name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xff8e8e93),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Route createOtherProfileScreenRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          OtherProfileScreen(
        userData: userData,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
