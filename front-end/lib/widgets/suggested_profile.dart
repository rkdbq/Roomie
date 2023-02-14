import 'package:flutter/material.dart';
import 'package:roomie/screens/home_screen.dart';
import 'package:roomie/widgets/commonalities.dart';
import 'package:roomie/widgets/difference.dart';

class SuggestedProfile extends StatelessWidget {
  String major, studentNumber, dormitoryInfo, message;
  Color color = randomColor();
  SuggestedProfile({
    super.key,
    required this.color,
    this.major = "컴퓨터공학부",
    this.studentNumber = "19",
    this.dormitoryInfo = "새빛1관",
    this.message = "안녕하세요",
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => print("remove $color"),
                    icon: const Icon(
                      Icons.person_remove,
                      color: Color(0xffe3242b),
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xff2832c2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5),
                    onPressed: () => print("profile about $color"),
                    icon: const Icon(
                      Icons.insert_drive_file_rounded,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "프로필",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xff028a0f),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5,
                    ),
                    onPressed: () => print("new chat with $color"),
                    icon: const Icon(
                      Icons.chat_bubble_outlined,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "새 채팅",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
