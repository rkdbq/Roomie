import 'package:flutter/widgets.dart';
import 'package:roomie/widgets/profile_scroll.dart';

import '../../classes/user_data.dart';

class MyProfileScreen extends StatelessWidget {
  late UserData userData;
  MyProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileScroll(
      userData: userData,
      isMyProfile: true,
    );
  }
}
