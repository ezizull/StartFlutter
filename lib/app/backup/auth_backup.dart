import 'dart:math';

import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:start/app/models/dummy_data.dart';
import 'package:start/app/models/friend.dart';
import 'package:start/app/routes/app_pages.dart';

class Auth_Backup extends GetxController {
  List<Map<String, dynamic>> dummy = DummyData.data;
  List<Friend> firends = [];
  final random = Random();

  RxString id = ''.obs;
  RxString nim = ''.obs;
  RxString nama = ''.obs;
  RxString token = ''.obs;
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxBool valid = false.obs;

  void faker() {
    for (var id = 0; id < 3; id++) {
      var fake = new Faker();
      firends.add(Friend(
        phone: '085342219343',
        firstname: fake.person.firstName(),
        lastname: random.nextBool() ? fake.person.lastName() : '',
        username: fake.internet.userName(),
        online: random.nextBool(),
        id: id,
      ));
    }
  }

  void validation(String email, String password) {
    for (var data in dummy) {
      if ((data['nama'] == email && data['Nim'] == password) ||
          (data['username'] == email && data['password'] == password)) {
        valid.value = true;
        id.value = data['id'].toString();
        nim.value = data['Nim'];
        nama.value = data['nama'];
        username.value = data['username'];
        this.password.value = data['password'];
        Get.offAllNamed(Routes.ROOT);
      }
    }
    update();
  }

  void unvalid() {
    if (valid.isTrue) {
      valid.value = false;
      id.value = '';
      nim.value = '';
      nama.value = '';
      username.value = '';
      password.value = '';
    }
    update();
  }
}
