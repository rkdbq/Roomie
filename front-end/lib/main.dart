import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:roomie/classes/random_color.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/firebase_options.dart';
import 'package:roomie/screens/navigation_screen.dart';
import 'package:roomie/screens/survey_screen.dart';
import 'package:roomie/themes/roomie_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  final bool isSurveyDone = false;
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const email = "rkdbg11752@jbnu.ac.kr";
    UserData myData = UserData(
      email: email,
      name: "test",
      password: "test123",
      surveyData: SurveyData(),
      color: randomColor(),
    );
    final users = FirebaseFirestore.instance.collection("users");
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(email).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return MaterialApp(
            home: SurveyScreen(userData: myData),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingContainer();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: NavigationScreen(
              userData: UserData.fromFirestore(snapshot.data!),
            ),
          );
        }

        return loadingContainer();
      },
    );
  }

  Container loadingContainer() {
    return Container(
      decoration: BoxDecoration(
        color: RoomieColor.background,
      ),
      child: Center(
        child: LoadingAnimationWidget.flickr(
            leftDotColor: RoomieColor.mainText,
            rightDotColor: RoomieColor.subText,
            size: 50),
      ),
    );
  }
}
