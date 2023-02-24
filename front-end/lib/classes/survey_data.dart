abstract class Answer {
  late List<String> items;
  String answer(int index);
}

class SleepAt implements Answer {
  @override
  List<String> items = [
    "오후 10시 이전",
    "오후 10시 ~ 오전 0시",
    "오전 0시 ~ 오전 2시",
    "오전 2시 ~ 오전 4시",
    "오전 4시 이후",
  ];

  @override
  String answer(int index) {
    return "${items[index]}에 잠드는 편이에요.";
  }
}

class AwakeAt implements Answer {
  @override
  List<String> items = [
    "오전 8시 이전",
    "오전 8시 ~ 오전 10시",
    "오전 10시 ~ 오후 12시",
    "오후 12시 ~ 오후 2시",
    "오후 2시 이후",
  ];

  @override
  String answer(int index) {
    return "${items[index]}에 일어나는 편이에요.";
  }
}

class CleaningPeriod implements Answer {
  @override
  List<String> items = [
    "어쩌다 한 번",
    "한달에 한 번",
    "격주에 한 번",
    "일주에 한 번",
    "매일",
  ];

  @override
  String answer(int index) {
    return "${items[index]} 청소하는 편이에요.";
  }
}

class SleepingHabit implements Answer {
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
}

class Extroversion implements Answer {
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
}

class RelationshipWithRoomie implements Answer {
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
    "기타": "상대방에게 전하고 싶은 말을 작성해주세요."
  };
}
