import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../widgets/chat_function/chat_user.dart';
import '../../widgets/chat_function/chat_user_card.dart';

class MyChattingScreen extends StatefulWidget {
  const MyChattingScreen({super.key});

  @override
  State<MyChattingScreen> createState() => _MyChattingScreenState();
}

class _MyChattingScreenState extends State<MyChattingScreen> {
  List<ChatUser> list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            //data 로딩
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(child: CircularProgressIndicator());

            //data 로딩끝나고 보여줄때
            case ConnectionState.active:
            case ConnectionState.done:
              final data = snapshot.data?.docs;
              list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                return ListView.builder(
                    itemCount: list.length,
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .01),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ChatUserCard(
                        user: list[index],
                      );
                    });
              } else {
                return const Center(
                  child: Text(
                    '오류',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
