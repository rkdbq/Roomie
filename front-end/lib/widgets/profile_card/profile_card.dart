import 'package:flutter/material.dart';
import 'package:roomie/widgets/profile_card/profile_button.dart';

import '../../classes/user_data.dart';
import '../../screens/navigated_screens/deck_screens/other_profile_screen.dart';
import 'commonalities.dart';
import 'difference.dart';

class ProfileCard extends StatelessWidget {
  late UserData userData;
  late bool isMyProfile;
  ProfileCard({
    super.key,
    required this.userData,
    this.isMyProfile = false,
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
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xff8e8e93),
                  ),
                ),
                Text(
                  userData.studentNumber,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xff8e8e93),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  userData.studentNumber,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff8e8e93),
                  ),
                ),
                Text(
                  ": ${userData.surveyData.answers["기타"]}",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Color(0xff8e8e93),
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
                visible: !isMyProfile,
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
              visible: isMyProfile,
              child: const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  "이름",
                  style: TextStyle(
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
