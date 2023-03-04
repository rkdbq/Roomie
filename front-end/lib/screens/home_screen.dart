import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:roomie/screens/navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserData userData;
  const HomeScreen({
    super.key,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc("xeePOovlz7SLaGAQcCd1").get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          parceFirebaseData(snapshot);
          return NavigationScreen(userData: userData);
        }

        return const Text("loading");
      },
    );
  }

  void parceFirebaseData(AsyncSnapshot<DocumentSnapshot> snapshot) {
    Map<String, dynamic> firebaseData =
        snapshot.data!.data() as Map<String, dynamic>;
    userData.studentNumber = firebaseData["student_number"];
    userData.major = firebaseData["major"];
    userData.dormitoryInfo = firebaseData["dormitory_info"];
    userData.color = Color(firebaseData["color"]);
    userData.surveyData.answers.forEach((key, value) {
      userData.surveyData.answers[key] = firebaseData[key];
    });
  }
}
