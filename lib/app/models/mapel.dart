class Mapel {
  final int id;
  final String title;
  final List<String> about;
  final List<int> grades;
  final List<bool> present;
  final List<String> moduls;

  Mapel({
    required this.id,
    required this.title,
    this.about = const [],
    this.grades = const [],
    this.moduls = const [],
    this.present = const [],
  });

  int getId() {
    return id;
  }

  String getTitle() {
    return title;
  }

  int length() {
    return moduls.length;
  }

  String getAbout(int index) {
    return about[index];
  }

  String getModul(int index) {
    return moduls[index];
  }

  String getGrade(int index) {
    String hasil = '';
    int grade = grades[index];
    grade > 80
        ? hasil = 'A'
        : grade > 75
            ? hasil = 'B'
            : grade > 70
                ? hasil = 'C'
                : grade > 60
                    ? hasil = 'D'
                    : hasil = 'E';
    return hasil;
  }

  bool getPresent(int index) {
    return present[index];
  }
}
