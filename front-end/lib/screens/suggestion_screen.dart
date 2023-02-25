import 'package:flutter/cupertino.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

import '../classes/random_color.dart';
import '../widgets/suggested_profile/suggested_profile.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  int swipeCount = 0;
  List<SuggestedProfile> profiles = [];

  @override
  void initState() {
    super.initState();

    profiles.add(SuggestedProfile(
      color: const Color(0xffffffff),
      major: "컴퓨터공학부",
      studentNumber: "19",
      dormitoryInfo: "새빛1관",
      message: "안녕하세요",
    ));

    profiles.add(SuggestedProfile(
      color: randomColor(),
    ));
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
