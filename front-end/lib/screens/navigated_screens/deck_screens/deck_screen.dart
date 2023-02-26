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
    super.initState();

    profiles.add(ProfileCard(
      color: const Color(0xffffffff),
      userData: UserData(
        major: "컴퓨터공학부",
        studentNumber: "19",
        dormitoryInfo: "새빛1관",
        surveyData: SurveyData(),
      ),
    ));

    profiles.add(ProfileCard(
      color: randomColor(),
      userData: UserData(
        major: "컴퓨터공학부",
        studentNumber: "19",
        dormitoryInfo: "새빛1관",
        surveyData: SurveyData(),
      ),
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
        ProfileCard(
          color: randomColor(),
          userData: UserData(
            major: "컴퓨터공학부",
            studentNumber: "19",
            dormitoryInfo: "새빛1관",
            surveyData: SurveyData(),
          ),
        ),
      );
      swipeCount--;
    }
    setState(
      () {},
    );
  }
}
