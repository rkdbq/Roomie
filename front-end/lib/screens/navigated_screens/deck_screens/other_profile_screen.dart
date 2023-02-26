import 'package:flutter/material.dart';

import '../../../classes/user_data.dart';
import '../../../themes/roomie_color.dart';
import '../../../widgets/profile_scroll.dart';

class OtherProfileScreen extends StatelessWidget {
  late UserData userData;
  OtherProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            size: 28,
            color: RoomieColor.mainText,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: RoomieColor.appBar,
        elevation: 0,
      ),
      backgroundColor: RoomieColor.background,
      body: ProfileScroll(
        userData: userData,
        isMyProfile: false,
        isScrolled: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
