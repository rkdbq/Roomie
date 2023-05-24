import 'package:flutter/widgets.dart';

import '../../classes/user_data.dart';
import '../../widgets/detailed_profile.dart';

class MyProfileScreen extends StatelessWidget {
  final UserData userData;
  const MyProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return DetailedProfile(
      userData: userData,
      isMine: true,
    );
  }
}
