import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

import '../../../widgets/profile_card/profile_card.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  int swipeCount = 0;
  List<ProfileCard> profiles = [];
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  void initState() {
    QueryDocumentSnapshot<Object?> lastVisible;
    final first = users.orderBy("name").limit(10).get().then(
      (documentSnapshots) {
        lastVisible = documentSnapshots.docs[documentSnapshots.size - 1];
        for (var document in documentSnapshots.docs) {
          profiles.add(randomProfileCard(document));
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwipingDeck(
      onLeftSwipe: (p0) => {swipeDeck()},
      onRightSwipe: (p0) => {swipeDeck()},
      onDeckEmpty: () => {replaceDeck()},
      cardWidth: 300,
      cardDeck: profiles,
      swipeThreshold: 400.0,
    );
  }

  int swipeDeck() => swipeCount++;

  void replaceDeck() {
    setState(
      () {
        // swipeCount++;
        // profiles.clear();
        // while (swipeCount > 0) {
        //   profiles.add(
        //     randomProfileCard(),
        //   );
        //   swipeCount--;
        // }
      },
    );
  }

  ProfileCard randomProfileCard(
      QueryDocumentSnapshot<Object?> documentSnapshot) {
    return ProfileCard(
      userData: UserData.fromFirestore(documentSnapshot),
    );
  }
}
