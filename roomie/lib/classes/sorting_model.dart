import 'package:roomie/classes/user_data.dart';
import 'package:roomie/classes/weight.dart';

import '../widgets/profile_card/profile_card.dart';

class Pair<T1, T2> {
  final T1 first;
  final T2 second;

  Pair(this.first, this.second);
}

class Model {
  late UserData data;
  late Weight weight;

  Model({
    required this.data,
    required this.weight,
  });

  double getSimilarity(ProfileCard profile) {
    double similarity = 0;
    for (var key in weight.weight.keys) {
      // score = wegiht * (1- 설문 조사 결과 차이 정규화한 값)
      var score = (weight.weight[key]! *
          (1 -
              (data.surveyData.answers[key] -
                          profile.userData.surveyData.answers[key])
                      .abs() /
                  profile.userData.surveyData.maxValue[key]));
      similarity = similarity + score;
    }
    return similarity;
  }

  Map<String, double> getScoreMap(ProfileCard profile) {
    Map<String, double> scores = {};
    for (var key in weight.weight.keys) {
      // score = wegiht * (1- 설문 조사 결과 차이 정규화한 값)
      var score = (weight.weight[key]! *
          (1 -
              (data.surveyData.answers[key] -
                          profile.userData.surveyData.answers[key])
                      .abs() /
                  profile.userData.surveyData.maxValue[key]));
      scores[key] = score;
    }
    return scores;
  }

  List<ProfileCard> sort(List<ProfileCard> profiles) {
    List<Pair<double, ProfileCard>> weightedProfiles = [];

    for (var profile in profiles) {
      var similarity = getSimilarity(profile);
      print("${profile.userData.email}: $similarity");
      weightedProfiles.add(Pair(similarity, profile));
    }
    weightedProfiles.sort((a, b) => b.first.compareTo(a.first));

    List<ProfileCard> sortedProfiles = [];
    for (var profile in weightedProfiles) {
      sortedProfiles.add(profile.second);
    }
    return sortedProfiles;
  }
}
