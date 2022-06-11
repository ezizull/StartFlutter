import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/controllers/firebase_auth_controller.dart';
import 'package:start/app/screens/register/controllers/register_controller.dart';

class RegisterBackupView extends GetView<RegisterController> {
  RegisterBackupView({Key? key}) : super(key: key);

  final fire_authc = Get.find<FirebaseAuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('ffffff'),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.9],
                    colors: [HexColor('b5c6e0'), HexColor('ebf4f5')])),
          ),
          Form(
            key: controller.registerFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 42),
                  child: textBar(
                    colors: [HexColor('2c698d')],
                    text: 'GalleryHub',
                    font: 'AndersonGrotesk',
                    fontweight: FontWeight.w900,
                    size: 38,
                  ),
                ),
                Obx(() => Container(
                      height: 50,
                      width: 320,
                      margin: EdgeInsets.only(bottom: 18),
                      child: TextField(
                        controller: controller.nameController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            child: Icon(
                              Icons.person,
                              size: 25,
                              color: controller.error_name.value == 'wrong name'
                                  ? HexColor('E46163')
                                  : HexColor('2c698d'),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.only(left: 5, right: 5, top: 35),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )),
                Obx(() => Container(
                      height: 50,
                      width: 320,
                      margin: EdgeInsets.only(bottom: 18),
                      child: TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            child: Icon(
                              Icons.email,
                              size: 25,
                              color: controller.email.value == 'wrong email'
                                  ? HexColor('E46163')
                                  : HexColor('2c698d'),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.only(left: 5, right: 5, top: 35),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )),
                Obx(() => Container(
                      height: 50,
                      width: 320,
                      margin: EdgeInsets.only(bottom: 18),
                      child: TextField(
                        controller: controller.passwordController,
                        obscureText: controller.onchange.value,
                        onChanged: (text) {
                          text == controller.password.value
                              ? controller.onChange(false)
                              : controller.onChange(true);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 5),
                            child: Icon(
                              Icons.key,
                              size: 25,
                              color:
                                  controller.password.value == 'wrong password'
                                      ? HexColor('E46163')
                                      : HexColor('2c698d'),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.only(left: 5, right: 5, top: 35),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )),
                ElevatedButton(
                  onPressed: () {
                    // fire_authc.signup(controller.emailc.text, controller.passwc.text);
                    if (controller.validate()) {}
                    ;
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'AndersonGrotesk',
                        fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(320, 50),
                    primary: HexColor('2c698d'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('I Have an Account'),
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: HexColor('2c698d')),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
