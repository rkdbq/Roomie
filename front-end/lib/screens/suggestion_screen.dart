import 'package:flutter/material.dart';
import 'package:roomie/widgets/suggested_profile.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';
import '../classes/random_color.dart';

//사용자에게 추천된 룸메이트 후보(suggested_profile)들을 보여줌
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
