class Chat {
  final String id;
  final String time;
  final String message;
  final String username;

  Chat(
      {required this.id,
      required this.username,
      required this.message,
      required this.time});

  String getTime() {
    return this.time;
  }

  String getMessage() {
    return this.message;
  }
}
