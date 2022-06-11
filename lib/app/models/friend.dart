import 'dart:convert';

Friends friendsFromJson(String str) => Friends.fromJson(json.decode(str));

String friendsToJson(Friends data) => json.encode(data.toJson());

class Friends {
  Friends({
    required this.message,
    required this.data,
  });

  String message;
  List<Friend> data;

  factory Friends.fromJson(Map<String, dynamic> json) => Friends(
        message: json["message"],
        data: List<Friend>.from(json["data"].map((x) => Friend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  static List<Friend> listFromJson(List<dynamic> list) =>
      List<Friend>.from(list.map((x) => Friend.fromJson(x)));
}

class Friend {
  Friend({
    required this.id,
    required this.firstname,
    required this.username,
    this.pivot,
    this.lastname = '',
    this.online = false,
    this.phone = '',
    this.age,
  });

  int id;
  String firstname;
  String lastname;
  String phone;
  Pivot? pivot;
  final String username;
  final bool online;
  final int? age;

  String imgUrl() {
    return imgUrl != ''
        ? 'https://picsum.photos/id/${this.id.toString()}/300/300'
        : '';
  }

  int getId() {
    return id;
  }

  int getAge() {
    return age ?? 0;
  }

  String getPhone() {
    return phone;
  }

  bool getOnline() {
    return online;
  }

  String getLastName() {
    return lastname.isNotEmpty ? lastname : '';
  }

  String getFirstName() {
    return firstname;
  }

  String getFullName() {
    String newLastName = lastname.isNotEmpty ? lastname : '';
    return newLastName != '' ? firstname + " " + newLastName : firstname;
  }

  String getUserName() {
    return username;
  }

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["id"],
        firstname: json["firstname"],
        username: json["firstname"],
        lastname: json["lastname"],
        phone: json["phone"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "pivot": pivot!.toJson(),
      };

  static List<Friend> listFromJson(List<dynamic> list) =>
      List<Friend>.from(list.map((x) => Friend.fromJson(x)));
}

class Pivot {
  Pivot({
    required this.userId,
    required this.friendId,
  });

  int userId;
  int friendId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        friendId: json["friend_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "friend_id": friendId,
      };
}
