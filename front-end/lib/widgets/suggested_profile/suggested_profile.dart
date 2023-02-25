import 'package:flutter/material.dart';
import 'package:roomie/widgets/suggested_profile/profile_button.dart';

import '../../classes/random_color.dart';
import 'commonalities.dart';
import 'difference.dart';

class SuggestedProfile extends StatelessWidget {
  String major, studentNumber, dormitoryInfo, message;
  Color color = randomColor();
  late bool isMyProfile;
  SuggestedProfile({
    super.key,
    required this.color,
    this.major = "전공",
    this.studentNumber = "00",
    this.dormitoryInfo = "생활관",
    this.message = "간단한 메시지",
    this.isMyProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: color,
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
                  major,
                  style: const TextStyle(
                    fontSize: 30,
                    color: Color(0xff8e8e93),
                  ),
                ),
                Text(
                  studentNumber,
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
                  dormitoryInfo,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff8e8e93),
                  ),
                ),
                Text(
                  ": $message",
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
                    const ProfileButton(
                      backgroundColor: Color(0xff2832c2),
                      iconData: Icons.description_rounded,
                      labelText: "프로필",
                    ),
                    const ProfileButton(
                      backgroundColor: Color(0xff028a0f),
                      iconData: Icons.chat_bubble_rounded,
                      labelText: "새 채팅",
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
}
