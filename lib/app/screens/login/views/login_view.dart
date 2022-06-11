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

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final authc = Get.find<AuthController>();
  final loginc = Get.put(LoginController());
  late DioClient dioClient = DioClient();
  late Future<User> user;

  final FocusNode emailf = FocusNode();

  @override
  void initState() {
    super.initState();
    emailf.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: HexColor('ffffff'),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                  0.5,
                  0.8,
                  0.9
                ],
                    colors: [
                  HexColor('FEFFFF'),
                  HexColor('E7F2F8'),
                  HexColor('CFE4F1')
                ])),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: sheight / 15,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(bottom: sheight / 10),
                padding: EdgeInsets.symmetric(horizontal: swidth / 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textBar(
                      colors: [HexColor('2c698d')],
                      text: 'GalleryHub',
                      font: 'AndersonGrotesk',
                      fontweight: FontWeight.w900,
                      size: 38,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: textBar(
                        colors: [HexColor('5D5D72')],
                        text: 'welcome to our app',
                        font: 'AndersonGrotesk',
                        fontweight: FontWeight.w100,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: sheight / 20,
                width: 320,
                margin: EdgeInsets.only(bottom: sheight / 20),
                child: TextField(
                  focusNode: emailf,
                  controller: loginc.emailc,
                  decoration: InputDecoration(
                    hintText: 'email',
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.25, color: HexColor('7CA0B6')),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.5, color: HexColor('52B4D8')),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 320,
                height: sheight / 20,
                margin: EdgeInsets.only(bottom: 0),
                child: TextField(
                  controller: loginc.passwc,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'password',
                    contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.25, color: HexColor('7CA0B6')),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(width: 1.5, color: HexColor('52B4D8')),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: sheight / 18),
                padding: EdgeInsets.symmetric(horizontal: swidth / 20),
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.REPASS);
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                          fontSize: 15,
                          color: HexColor('2c698d'),
                          fontFamily: 'AndersonGrotesk',
                          fontWeight: FontWeight.w800),
                    )),
              ),
              Wrap(
                runSpacing: 10,
                direction: Axis.vertical,
                spacing: sheight / 50,
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
                      'SignIn',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
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
                    onPressed: () async {},
                    child: Text(
                      'Google SignIn',
                      style: TextStyle(
                          color: HexColor('2c698d'),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'AndersonGrotesk',
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(320, 50),
                      primary: HexColor('ffffff'),
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
                    Text(
                      'Don\'t Have an Account',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 15,
                            color: HexColor('2c698d'),
                            fontWeight: FontWeight.w800,
                          ),
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
