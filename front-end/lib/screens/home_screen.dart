import 'dart:math';

import 'package:flutter/material.dart';
import 'package:roomie/widgets/profile.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

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
  List<Profile> profiles = [];

  @override
  void initState() {
    super.initState();

    profiles.add(Profile(
      color: const Color(0xffffffff),
    ));

    profiles.add(Profile(
      color: randomColor(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff1f3),
      body: SwipingDeck(
        onLeftSwipe: (p0) {
          profiles.add(
            Profile(
              color: randomColor(),
            ),
          );
        },
        onRightSwipe: (p0) => {},
        onDeckEmpty: () => setState(() => {}),
        cardWidth: 300,
        cardDeck: profiles,
        swipeThreshold: 400.0,
      ),
    );
  }
}
