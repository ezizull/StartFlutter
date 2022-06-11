class Chat {
  final String id;
  final String time;
  final String message;
  final String username;
  final String friend_id;

  Chat(
      {required this.id,
      required this.username,
      required this.message,
      required this.time,
      required this.friend_id});

  String getId() {
    return this.id;
  }

  String getFriendId() {
    return this.friend_id;
  }

  String getTime() {
    return this.time;
  }

  String getUsername() {
    return this.username;
  }

  String getMessage() {
    return this.message;
  }
}
