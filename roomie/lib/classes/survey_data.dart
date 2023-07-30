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
    "오후 10시 ~ 오후 11시",
    "오후 11시 ~ 오전 0시",
    "오전 0시 ~ 오전 1시",
    "오전 1시 ~ 오전 2시",
    "오전 2시 ~ 오전 3시",
    "오전 3시 이후",
    "매우 불규칙적인 시간"
  ];

  @override
  String title() {
    return "취침시간";
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

class RoomCleaning implements PossibleAnswer {
  @override
  List<String> items = [
    "한달에 한 번 미만",
    "한달에 한 번",
    "격주일에 한 번",
    "일주일에 한 번",
    "일주일에 한 번 이상",
  ];

  @override
  String title() {
    return "방 청소주기";
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

class RestroomCleaning implements PossibleAnswer {
  @override
  List<String> items = [
    "한달에 한 번 미만",
    "한달에 한 번",
    "격주일에 한 번",
    "일주일에 한 번",
    "일주일에 한 번 이상",
  ];

  @override
  String title() {
    return "화장실 청소주기";
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
    "없는",
    "가끔 있는",
    "자주 있는",
    "항상 있는",
    "잠버릇이 있는지 모르겠어요.",
  ];

  @override
  String title() {
    return "잠버릇";
  }

  @override
  String answer(int index) {
    if (index < 4) {
      return "잠버릇이 ${items[index]} 편이에요.";
    } else {
      return items[index];
    }
  }

  @override
  String icon() {
    return "😪";
  }
}

class Relationship implements PossibleAnswer {
  @override
  List<String> items = [
    "비즈니스",
    "식사 하는 사이",
    "친한 친구",
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
    return items[index];
  }

  @override
  String icon() {
    return "🚬";
  }
}

class Earphone implements PossibleAnswer {
  @override
  List<String> items = [
    "선호해요.",
    "선호하지 않아요.",
  ];

  @override
  String title() {
    return "이어폰";
  }

  @override
  String answer(int index) {
    return items[index];
  }

  @override
  String icon() {
    return "🎧";
  }
}

class Eating implements PossibleAnswer {
  @override
  List<String> items = [
    "선호해요.",
    "선호하지 않아요.",
  ];

  @override
  String title() {
    return "실내취식";
  }

  @override
  String answer(int index) {
    return items[index];
  }

  @override
  String icon() {
    return "🍜";
  }
}

class Calling implements PossibleAnswer {
  @override
  List<String> items = [
    "선호해요.",
    "선호하지 않아요.",
  ];

  @override
  String title() {
    return "실내통화";
  }

  @override
  String answer(int index) {
    return items[index];
  }

  @override
  String icon() {
    return "📞";
  }
}

class Inviting implements PossibleAnswer {
  @override
  List<String> items = [
    "선호해요.",
    "선호하지 않아요.",
  ];

  @override
  String title() {
    return "친구 초대";
  }

  @override
  String answer(int index) {
    return items[index];
  }

  @override
  String icon() {
    return "📞";
  }
}

class Sharing implements PossibleAnswer {
  @override
  List<String> items = [
    "선호해요.",
    "선호하지 않아요.",
  ];
  @override
  String title() {
    return "물건 공유";
  }

  @override
  String answer(int index) {
    return items[index];
  }

  @override
  String icon() {
    return "📞";
  }
}

class LateStandUsing implements PossibleAnswer {
  @override
  List<String> items = [
    "선호해요.",
    "선호하지 않아요.",
  ];

  @override
  String title() {
    return "늦은 밤 스탠드";
  }

  @override
  String answer(int index) {
    return items[index];
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
    return "룸메이트 후보들에게 전하고 싶은 말을 작성해주세요.";
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
    "smoking": 0,
    "sleeping_habits": 2,
    "relationship": 1,
    "sleep_at": 2,
    "room_cleaning": 2,
    "restroom_cleaning": 2,
    "inviting": 0,
    "sharing": 0,
    "calling": 0,
    "earphone": 0,
    "eating": 0,
    "late_stand_using": 0,
    "etc": "저는 축구를 좋아해요! ⚽️"
  };

  Map maxValue = {
    "smoking": 1,
    "sleeping_habits": 4,
    "relationship": 2,
    "sleep_at": 6,
    "room_cleaning": 4,
    "restroom_cleaning": 4,
    "inviting": 1,
    "sharing": 1,
    "calling": 1,
    "earphone": 1,
    "eating": 1,
    "late_stand_using": 1,
  };
}
