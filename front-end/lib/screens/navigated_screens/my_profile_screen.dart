import 'package:flutter/widgets.dart';
import 'package:roomie/widgets/profile_scroll.dart';

import '../../classes/user_data.dart';

class MyProfileScreen extends StatefulWidget {
  late UserData userData;
  late List<Color> colors;
  MyProfileScreen({
    super.key,
    required this.userData,
    required this.colors,
  });

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ProfileScroll(
      userData: widget.userData,
      colors: widget.colors,
      isMyProfile: true,
    );
  }
}
