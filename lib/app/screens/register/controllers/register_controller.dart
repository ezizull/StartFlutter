import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RegisterController extends GetxController {
  final registerFormKey = GlobalKey<FormState>();
  late TextEditingController nameController,
      emailController,
      passwordController;
  var name = ''.obs, error_name = ''.obs, email = ''.obs, password = ''.obs;

  var isLoading = false.obs;
  var onchange = true.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController(text: '12345678');
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool validate() {
    if (!GetUtils.isNull(nameController.text) ||
        passwordController.text.length <= 7 ||
        !GetUtils.isEmail(emailController.text)) {
      if (passwordController.text.length <= 7) {
        passwordController.text = 'wrong password';
        password.value = 'wrong password';
        onChange(false);
      } else {
        password.value = passwordController.text;
      }

      email.value = emailController.text;
      if (!GetUtils.isEmail(email.value)) {
        emailController.text = 'wrong email';
        email.value = 'wrong email';
      }

      name.value = nameController.text;
      if (name.value.length < 1) {
        nameController.text = 'wrong name';
        error_name.value = 'wrong name';
      } else {
        error_name.value = '';
      }

      update();
      return false;
    }

    return true;
  }

  void onChange(bool value) {
    onchange.value = value;
    update();
  }
}
