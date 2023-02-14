import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roomie/widgets/suggested_profile.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

//사용자에게 추천된 룸메이트 후보(suggested_profile)들을 보여줌
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Color randomColor() {
  var r = Random().nextInt(255);
  var g = Random().nextInt(255);
  var b = Random().nextInt(255);
  return Color.fromRGBO(r, g, b, 1);
}

class _HomeScreenState extends State<HomeScreen> {
  int swipeCount = 0;
  List<SuggestedProfile> profiles = [];

  @override
  void initState() {
    super.initState();

    profiles.add(SuggestedProfile(
      color: const Color(0xffffffff),
    ));

    profiles.add(SuggestedProfile(
      color: randomColor(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      //SwipingDeck 패키지 사용
      body: SwipingDeck(
        onLeftSwipe: (p0) => {swipeDeck()},
        onRightSwipe: (p0) => {swipeDeck()},
        onDeckEmpty: () => {replaceDeck()},
        cardWidth: 300,
        cardDeck: profiles,
        swipeThreshold: 400.0,
      ),
    );
  }

  int swipeDeck() => swipeCount++;

  void replaceDeck() {
    swipeCount++;
    profiles.clear();
    while (swipeCount > 0) {
      profiles.add(
        SuggestedProfile(
          color: randomColor(),
        ),
      );
      swipeCount--;
    }
    setState(
      () {},
    );
  }
}
