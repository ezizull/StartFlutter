import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/models/users.dart';
import 'package:start/app/routes/app_pages.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/controllers/firebase_auth_controller.dart';
import 'package:start/app/screens/login/controllers/login_controller.dart';
import 'package:start/app/services/dio_client.dart';

class LoginBackupView extends StatefulWidget {
  @override
  State<LoginBackupView> createState() => _LoginBackupViewState();
}

class _LoginBackupViewState extends State<LoginBackupView> {
  final firebaseAuthc = Get.find<FirebaseAuthController>();
  final authc = Get.find<AuthController>();
  final loginc = Get.put(LoginController());
  late DioClient dioClient = DioClient();
  late Future<User> user;

  @override
  void initState() {
    super.initState();
  }

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
                    stops: [0.0, 0.9],
                    colors: [HexColor('b5c6e0'), HexColor('ebf4f5')])),
          ),
          Column(
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
                  size: 38,
                ),
              ),
              Container(
                height: 50,
                width: 320,
                margin: EdgeInsets.only(bottom: 18),
                child: TextField(
                  controller: loginc.emailc,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Icon(
                        Icons.email,
                        size: 25,
                        color: HexColor('2c698d'),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 5, right: 5, top: 35),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: 320,
                margin: EdgeInsets.only(bottom: 0),
                child: TextField(
                  controller: loginc.passwc,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Icon(
                        Icons.key,
                        size: 25,
                        color: HexColor('2c698d'),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.only(left: 5, right: 5, top: 35),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.symmetric(horizontal: 40),
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.REPASS);
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontFamily: 'AndersonGrotesk',
                          color: HexColor('2c698d'),
                          fontWeight: FontWeight.w600),
                    )),
              ),
              Wrap(
                runSpacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // firebaseAuthc.login(loginc.emailc.text, loginc.passwc.text);
                      // firebaseAuthc.validation(loginc.emailc.text, loginc.passwc.text);

                      dioClient.fetchLogin(
                          email: loginc.emailc.text,
                          password: loginc.passwc.text,
                          device: 'mobile');
                    },
                    child: Text(
                      'Login',
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
                  ElevatedButton(
                    onPressed: () async {
                      firebaseAuthc.googleauth();
                    },
                    child: Text(
                      'Google SignIn',
                      style: TextStyle(
                          color: HexColor('2c698d'),
                          fontWeight: FontWeight.w500,
                          fontFamily: 'AndersonGrotesk',
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(320, 50),
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t Have an Account'),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(color: HexColor('2c698d')),
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
