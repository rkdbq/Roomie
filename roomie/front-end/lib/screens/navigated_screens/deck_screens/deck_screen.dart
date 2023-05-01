import 'package:flutter/cupertino.dart';
import 'package:roomie/classes/survey_data.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

import '../../../classes/random_color.dart';
import '../../../widgets/profile_card/profile_card.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  int swipeCount = 0;
  List<ProfileCard> profiles = [];

  @override
  void initState() {
    profiles.add(randomProfileCard());
    profiles.add(randomProfileCard());
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
        swipeCount++;
        profiles.clear();
        while (swipeCount > 0) {
          profiles.add(
            randomProfileCard(),
          );
          swipeCount--;
        }
      },
    );
  }

  ProfileCard randomProfileCard() {
    return ProfileCard(
      userData: UserData(
        surveyData: SurveyData(),
        color: randomColor(),
      ),
    );
  }
}
