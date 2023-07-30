import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class Weight {
  late Map<String, dynamic> index;
  late Map<String, double> weight;

  Weight({
    required this.index,
    required this.weight,
  });

  factory Weight.fromFirestore(
    DocumentSnapshot snapshot,
    String tag,
  ) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Weight(
      index: data,
      weight: getWeightMap(data, tag),
    );
  }

  Map<String, dynamic> toFirestore() {
    return index;
  }

  static double getWeight(double index) {
    return 1 / (1 + exp(-index));
  }

  static Map<String, double> getWeightMap(
      Map<String, dynamic> index, String tag) {
    Map<String, double> weightMap = {};
    for (var key in index.keys) {
      double i;
      if (tag.compareTo(key) != 0) {
        i = index[key]!;
      } else {
        i = index[key]! * 2;
      }
      weightMap[key] = getWeight(i);
    }
    print("getWeigtMap: $weightMap");
    return weightMap;
  }

  void changeWeight(String content, double indexGradient) {
    index[content] = index[content]! + indexGradient;
  }

  void changeWeightMap(Map<String, double> scores) {
    // score를 크기 순 정렬하여 작은 50%의 index는 +0.1, 큰 50%의 index는 -0.1
    List<MapEntry<String, dynamic>> scoreList = scores.entries.toList();
    scoreList.sort((a, b) => a.value.compareTo(b.value));

    int half = (scoreList.length / 2).round();
    int length = scoreList.length;
    for (int i = 0; i < length; i++) {
      var key = scoreList[i].key;
      if (i < half) {
        index[key] += 0.1;
      } else {
        index[key] -= 0.1;
      }
    }
  }

  void indexInitialize() {
    for (var key in index.keys) {
      index[key] = 0;
    }
  }
}
