import 'dart:math';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:roomie/classes/user_data.dart';
import 'package:swiping_card_deck/swiping_card_deck.dart';

import '../../../classes/sorting_model.dart';
import '../../../classes/weight.dart';
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
  Weight weight = Weight(index: {}, weight: {});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userData.email);
    // user.update(
    //   {"search_tag": "none"},
    // );
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (profiles.isEmpty) {
            fillCardDeck(snapshot);
          }
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
                      initialIndex:
                          widget.userData.tagToNum[widget.userData.searchTag],
                      length: 13,
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
                              replaceDeck(snapshot);
                            },
                            tabs: const [
                              Tab(
                                text: "전체",
                              ),
                              Tab(
                                text: "흡연",
                              ),
                              Tab(
                                text: "잠버릇",
                              ),
                              Tab(
                                text: "관계",
                              ),
                              Tab(
                                text: "취침시간",
                              ),
                              Tab(
                                text: "방 청소",
                              ),
                              Tab(
                                text: "화장실 청소",
                              ),
                              Tab(
                                text: "초대",
                              ),
                              Tab(
                                text: "공유",
                              ),
                              Tab(
                                text: "전화",
                              ),
                              Tab(
                                text: "이어폰",
                              ),
                              Tab(
                                text: "취식",
                              ),
                              Tab(
                                text: "스탠드",
                              ),
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
                    onLeftSwipe: (p0) => {
                      swipeDeck(FirebaseFirestore.instance
                          .collection("users")
                          .doc("weights"))
                    },
                    onRightSwipe: (p0) => {
                      swipeDeck(FirebaseFirestore.instance
                          .collection("users")
                          .doc("weights"))
                    },
                    onDeckEmpty: () => {replaceDeck(snapshot)},
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

  void fillCardDeck(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    var querySnapshot = snapshot.data!;
    for (var documentSnapshot in querySnapshot.docs) {
      {
        if (documentSnapshot.id == "weights") {
          weight =
              Weight.fromFirestore(documentSnapshot, widget.userData.searchTag);
        } else {
          if (documentSnapshot.id == widget.userData.email) continue;
          profiles.add(
            ProfileCard(
              userData: UserData.fromFirestore(documentSnapshot),
            ),
          );
        }
      }
    }

    Model model = Model(data: widget.userData, weight: weight);
    profiles = model.sort(profiles);
  }

  Future<QuerySnapshot> getData() async {
    var users = FirebaseFirestore.instance.collection('users');
    return users.get();
  }

  void swipeDeck(DocumentReference<Map<String, dynamic>> user) {
    Model model = Model(data: widget.userData, weight: weight);
    var scores = model.getScoreMap(profiles[card_index]);
    print(scores);
    weight.changeWeightMap(scores);
    user.update(weight.toFirestore());
    card_index++;
  }

  void replaceDeck(AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
    profiles.clear();
    card_index = 0;
    disabled = false;
    fillCardDeck(snapshot);
    setState(() {});
  }

  void undoDeck() {
    card_index--;
    disabled = true;

    profiles = profiles.sublist(max(card_index, 0), profiles.length);
    setState(() {});
  }
}
