import 'package:buttons_tabbar/buttons_tabbar.dart';
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
  ScrollController scrollController = ScrollController();
  int swipeCount = 0, card_index = 0;
  bool disabled = false;
  List<ProfileCard> profiles = [], temp = [];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userData.email);
    user.update(
      {"search_tag": "none"},
    );
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          fillCardDeck(snapshot, card_index);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 50,
                    child: DefaultTabController(
                      length: 11,
                      child: Column(
                        children: <Widget>[
                          ButtonsTabBar(
                            labelStyle: TextStyle(
                                fontSize: 18, color: RoomieColor.subText),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            backgroundColor: widget.userData.color,
                            height: 48,
                            onTap: (p0) {
                              widget.userData.searchTag =
                                  widget.userData.numToTag[p0];
                              user.update(
                                {"search_tag": widget.userData.searchTag},
                              );
                            },
                            tabs: const [
                              Tab(
                                text: "전체",
                              ),
                              Tab(
                                text: "취침시간",
                              ),
                              Tab(
                                text: "기상시간",
                              ),
                              Tab(
                                text: "청소주기",
                              ),
                              Tab(
                                text: "잠버릇",
                              ),
                              Tab(
                                text: "외향성",
                              ),
                              Tab(
                                text: "관계",
                              ),
                              Tab(
                                text: "흡연",
                              ),
                              Tab(
                                text: "이어폰",
                              ),
                              Tab(
                                text: "취식",
                              ),
                              Tab(
                                text: "통화",
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.undo_rounded),
                        onPressed: disabled
                            ? null
                            : () {
                                undoDeck();
                              },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 75),
                      )
                    ],
                  ),
                  SwipingDeck(
                    onLeftSwipe: (p0) => {swipeDeck()},
                    onRightSwipe: (p0) => {swipeDeck()},
                    onDeckEmpty: () => {replaceDeck()},
                    cardWidth: 300,
                    cardDeck: profiles,
                    swipeThreshold: 400.0,
                  ),
                ],
              ),
              const SizedBox(),
            ],
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

  void fillCardDeck(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, int undoIndex) {
    var querySnapshot = snapshot.data!;
    var index = 0;
    for (var documentSnapshot in querySnapshot.docs) {
      {
        if (documentSnapshot.id == widget.userData.email) continue;
        if (undoIndex - 1 >= index++) continue;
        profiles.add(
          ProfileCard(
            index: index++,
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

  void swipeDeck() {
    card_index++;
    print(card_index);
  }

  void replaceDeck() {
    print(widget.userData.searchTag);
    card_index = 0;
    disabled = false;
    setState(
      () {},
    );
  }

  void undoDeck() {
    card_index--;
    disabled = true;
    setState(
      () {},
    );
  }
}
