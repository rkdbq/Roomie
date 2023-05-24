import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

import '../../../themes/roomie_color.dart';
import '../../../widgets/profile_card/profile_card.dart';

class DeckScreen extends StatefulWidget {
  final UserData userData;
  const DeckScreen({
    super.key,
    required this.userData,
  });

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  int swipeCount = 0;
  List<ProfileCard> profiles = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          fillCardDeck(snapshot);
          return SwipingDeck(
            onLeftSwipe: (p0) => {swipeDeck()},
            onRightSwipe: (p0) => {swipeDeck()},
            onDeckEmpty: () => {replaceDeck()},
            cardWidth: 300,
            cardDeck: profiles,
            swipeThreshold: 400.0,
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(color: RoomieColor.background),
          ),
        );
      },
    );
  }

  void fillCardDeck(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    var querySnapshot = snapshot.data!;
    for (var documentSnapshot in querySnapshot.docs) {
      {
        if (documentSnapshot.id == widget.userData.email) continue;
        profiles.add(
          ProfileCard(
            userData: UserData.fromFirestore(documentSnapshot),
          ),
        );
      }
    }
  }

  Future<QuerySnapshot> getData() async {
    print("getData");
    profiles.clear();
    var users = FirebaseFirestore.instance.collection('users');
    return users.orderBy("name").limit(10).get();
  }

  void swipeDeck() {}

  void replaceDeck() {
    setState(
      () {},
    );
  }
}
