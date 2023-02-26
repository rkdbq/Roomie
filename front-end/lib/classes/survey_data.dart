import 'package:roomie/classes/user_data.dart';

abstract class PossibleAnswer {
  late List<String> items;
  String icon();
  String answer(int index);
}

abstract class Comment {
  String icon();
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
  String answer(int index) {
    return "${items[index]} 청소하는 편이에요.";
  }

  @override
  String icon() {
    return "🧹";
  }
}

class SleepingHabit implements PossibleAnswer {
  @override
  List<String> items = [
    "거의 없는",
    "가끔 있는",
    "종종 있는",
    "잦은",
    "심한",
  ];

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
  String answer(int index) {
    return "${items[index]} 성격이에요.";
  }

  @override
  String icon() {
    return "🥳";
  }
}

class RelationshipWithRoomie implements PossibleAnswer {
  @override
  List<String> items = [
    "낯선 관계",
    "지인",
    "친구",
    "친한 친구",
    "베스트프렌드",
  ];

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
  String answer(int index) {
    return "$index";
  }

  @override
  String icon() {
    return "🎧";
  }
}

class IndoorDining implements PossibleAnswer {
  @override
  List<String> items = [
    "먹지 않아요.",
    "먹고 싶어요.",
  ];

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
  String helperText() {
    return "룸메이트 후보들에게 추가로 전하고 싶은 말을 작성해주세요.";
  }

  @override
  String hintText() {
    return data.surveyData.answers["기타"];
  }

  @override
  String icon() {
    return "💭";
  }
}

class SurveyData {
  Map answers = {
    "취침시간": 2,
    "기상시간": 2,
    "청소주기": 2,
    "관계": 2,
    "잠버릇": 2,
    "외향성": 2,
    "흡연": 0,
    "이어폰": 0,
    "실내취식": 0,
    "실내통화": 0,
    "기타": "저는 축구를 좋아해요! ⚽️"
  };
}
