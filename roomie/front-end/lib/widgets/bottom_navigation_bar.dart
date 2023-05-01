import 'package:flutter/material.dart';

import '../themes/roomie_color.dart';

class RoundedBottomNavigationBar extends StatelessWidget {
  final int index;
  Function(int value) onTap;
  RoundedBottomNavigationBar({
    super.key,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onTap: onTap),
      ),
    );
  }
}
