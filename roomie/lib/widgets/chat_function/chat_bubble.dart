import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble(this.message, this.isMe, this.userNickName, {super.key});

  final String message;
  final String userNickName;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              userNickName,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe ? Colors.white : Colors.black),
            ),
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(12),
                  topLeft: const Radius.circular(12),
                  bottomRight: isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(12),
                  bottomLeft: isMe
                      ? const Radius.circular(12)
                      : const Radius.circular(0),
                ),
              ),
              width: 145,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                message,
                style: TextStyle(
                  color: isMe ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
