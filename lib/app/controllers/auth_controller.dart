import 'dart:math';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/app/models/friend.dart';
import 'package:start/app/routes/app_pages.dart';
import 'package:start/app/services/dio_client.dart';

class AuthController extends GetxController {
  RxString id = ''.obs;
  RxString email = ''.obs;
  RxString token = ''.obs;
  RxString username = ''.obs;
  RxString password = ''.obs;
  RxBool valid = false.obs;

  late DioClient dioClient = DioClient();

  late Future<Friends> friend;
  List<Friend> friends = [];
  final random = Random();
  String timeNow = DateFormat('hh:mm a').format(DateTime.now());
  Friend? data;

  @override
  void onInit() {
    super.onInit();
  }

  void login({required dynamic data, required String password}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("valid", data['success']);
    pref.setString("id", data['user']['id'].toString());
    pref.setString("email", data['user']['email']);
    pref.setString("username", data['user']['name']);
    pref.setString('password', password);
    pref.setString("token", data['token']);

    valid.value = data['success'];
    id.value = data['user']['id'].toString();
    email.value = data['user']['email'];
    username.value = data['user']['name'];
    token.value = data['token'];

    if (valid.value) {
      final friend = await dioClient.fetchFriend(token: token.value);
      friends = friend.data;
      Get.offAllNamed(Routes.ROOT);
    }
    update();
  }

  void logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (valid.isTrue) {
      valid.value = false;
      id.value = '';
      email.value = '';
      username.value = '';
      password.value = '';
      token.value = '';

      pref.remove('valid');
      pref.remove('id');
      pref.remove('email');
      pref.remove('username');
      pref.remove('token');

      Get.offAllNamed(Routes.LOGIN);
    }
    update();
  }
}
