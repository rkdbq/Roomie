import 'package:flutter/material.dart';

import '../../../classes/user_data.dart';
import '../../../widgets/profile_scroll.dart';

class OtherProfileScreen extends StatefulWidget {
  late UserData userData;
  late List<Color> colors;
  OtherProfileScreen({
    super.key,
    required this.userData,
    required this.colors,
  });

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 28,
            color: Color(0xff8e8e93),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xffeff1f3),
      body: ProfileScroll(
        userData: widget.userData,
        colors: widget.colors,
        isMyProfile: false,
        isScrolled: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
