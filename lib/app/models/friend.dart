class Friend {
  final String? lastName;
  final String firstName;
  final String userName;
  final String? gender; // should required
  final String? birth;
  final String? about;
  final bool online;
  final int? age;
  final int id;

  Friend({
    required this.firstName,
    required this.userName,
    required this.id,
    this.online = false,
    this.lastName,
    this.gender,
    this.about,
    this.birth,
    this.age,
  });

  String imgUrl() {
    return imgUrl != ''
        ? 'https://picsum.photos/id/${this.id.toString()}/300/300'
        : '';
  }

  int getId() {
    return this.id;
  }

  String getGender() {
    return this.gender ?? '';
  }

  String getBirth() {
    return this.birth ?? '';
  }

  int getAge() {
    return this.age ?? 0;
  }

  String getAbout() {
    return this.about ?? '';
  }

  bool Online() {
    return this.online;
  }

  String getLastName() {
    return this.lastName ?? '';
  }

  String getFirstName() {
    return this.firstName;
  }

  String getFullName() {
    String newLastName = this.lastName ?? '';
    return newLastName != ''
        ? this.firstName + " " + newLastName
        : this.firstName;
  }

  String getUserName() {
    return this.userName;
  }
}
