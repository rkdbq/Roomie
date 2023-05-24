import 'package:roomie/classes/user_data.dart';

abstract class PossibleAnswer {
  late List<String> items;
  String title();
  String icon();
  String answer(int index);
}

abstract class Comment {
  String icon();
  String title();
  String helperText();
  String hintText();
}

class SleepAt implements PossibleAnswer {
  @override
  List<String> items = [
    "오후 10시 이전",
    "오후 10시 ~ 오전 0시",
    "오전 0시 ~ 오전 2시",
    "오전 2시 ~ 오전 4시",
    "오전 4시 이후",
  ];

  @override
  String title() {
    return "수면시간";
  }

  @override
  String icon() {
    return "🌜";
  }

  @override
  String answer(int index) {
    return "${items[index]}에 잠드는 편이에요.";
  }
}

class AwakeAt implements PossibleAnswer {
  @override
  List<String> items = [
    "오전 8시 이전",
    "오전 8시 ~ 오전 10시",
    "오전 10시 ~ 오후 12시",
    "오후 12시 ~ 오후 2시",
    "오후 2시 이후",
  ];

  @override
  String title() {
    return "취침시간";
  }

  @override
  String icon() {
    return "🌞";
  }

  @override
  String answer(int index) {
    return "${items[index]}에 일어나는 편이에요.";
  }
}

class CleaningPeriod implements PossibleAnswer {
  @override
  List<String> items = [
    "어쩌다 한 번",
    "한달에 한 번",
    "격주일에 한 번",
    "일주일에 한 번",
    "매일",
  ];

  @override
  String title() {
    return "청소주기";
  }

  @override
  String answer(int index) {
    return "${items[index]} 청소하는 편이에요.";
  }

  @override
  String icon() {
    return "🧹";
  }
}

class SleepingHabits implements PossibleAnswer {
  @override
  List<String> items = [
    "거의 없는",
    "가끔 있는",
    "종종 있는",
    "잦은",
    "심한",
  ];

  @override
  String title() {
    return "잠버릇";
  }

  @override
  String answer(int index) {
    return "잠버릇이 ${items[index]} 편이에요.";
  }

  @override
  String icon() {
    return "😪";
  }
}

class Extroversion implements PossibleAnswer {
  @override
  List<String> items = [
    "매우 내향적인",
    "내향적인",
    "보통인",
    "외향적인",
    "매우 외향적인",
  ];

  @override
  String title() {
    return "외향성";
  }

  @override
  String answer(int index) {
    return "${items[index]} 성격이에요.";
  }

  @override
  String icon() {
    return "🥳";
  }
}

class Relationship implements PossibleAnswer {
  @override
  List<String> items = [
    "낯선 관계",
    "지인",
    "친구",
    "친한 친구",
    "베스트프렌드",
  ];

  @override
  String title() {
    return "관계";
  }

  @override
  String answer(int index) {
    return "룸메이트와 ${items[index]}(으)로 지내고 싶어요.";
  }

  @override
  String icon() {
    return "👬";
  }
}

class Smoking implements PossibleAnswer {
  @override
  List<String> items = [
    "비흡연자예요.",
    "흡연자예요.",
  ];

  @override
  String title() {
    return "흡연";
  }

  @override
  String answer(int index) {
    return "$index";
  }

  @override
  String icon() {
    return "🚬";
  }
}

class Earphone implements PossibleAnswer {
  @override
  List<String> items = [
    "착용하지 않는 편이에요.",
    "착용하는 편이에요.",
  ];

  @override
  String title() {
    return "이어폰";
  }

  @override
  String answer(int index) {
    return "$index";
  }

  @override
  String icon() {
    return "🎧";
  }
}

class IndoorEating implements PossibleAnswer {
  @override
  List<String> items = [
    "먹지 않아요.",
    "먹고 싶어요.",
  ];

  @override
  String title() {
    return "실내취식";
  }

  @override
  String answer(int index) {
    return "$index";
  }

  @override
  String icon() {
    return "🍜";
  }
}

class IndoorCalling implements PossibleAnswer {
  @override
  List<String> items = [
    "통화하지 않아요.",
    "통화하고 싶어요.",
  ];

  @override
  String title() {
    return "실내통화";
  }

  @override
  String answer(int index) {
    return "$index";
  }

  @override
  String icon() {
    return "📞";
  }
}

class Etc implements Comment {
  late UserData data;
  Etc(this.data);

  @override
  String title() {
    return "기타";
  }

  @override
  String helperText() {
    return "룸메이트 후보들에게 추가로 전하고 싶은 말을 작성해주세요.";
  }

  @override
  String hintText() {
    return data.surveyData.answers["etc"];
  }

  @override
  String icon() {
    return "💭";
  }
}

class SurveyData {
  Map answers = {
    "sleep_at": 2,
    "awake_at": 2,
    "cleaning_period": 2,
    "relationship": 2,
    "sleeping_habits": 2,
    "extroversion": 2,
    "smoking": 0,
    "earphone": 0,
    "indoor_eating": 0,
    "indoor_calling": 0,
    "etc": "저는 축구를 좋아해요! ⚽️"
  };
}
