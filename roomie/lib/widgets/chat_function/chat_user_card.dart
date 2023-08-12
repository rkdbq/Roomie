import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'chat_user.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .04, vertical: 4),
      color: Colors.blue.shade100,
      elevation: 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
            leading: const CircleAvatar(child: Icon(CupertinoIcons.person)),
            title: Text(
              widget.user.userNickName,
            ),
            subtitle: Text(
              widget.user.userStudentNumber,
              maxLines: 1,
            ),
            trailing: const Text(
              '12:00 PM',
              style: TextStyle(color: Colors.black54),
            )),
      ),
    );
  }
}
