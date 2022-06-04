import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final emailC = TextEditingController(text: "yahanem979@musezoo.com");
  final passwC = TextEditingController(text: "12345678");

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
