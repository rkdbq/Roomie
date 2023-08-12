class ChatUser {
  ChatUser({
    required this.email,
    required this.userNickName,
    required this.userStudentNumber,
  });
  late String email;
  late String userNickName;
  late String userStudentNumber;

  ChatUser.fromJson(Map<String, dynamic> json) {
    email = json['email'] ?? '';
    userNickName = json['userNickName'] ?? '';
    userStudentNumber = json['userStudentNumber'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['userNickName'] = userNickName;
    data['userStudentNumber'] = userStudentNumber;
    return data;
  }
}
