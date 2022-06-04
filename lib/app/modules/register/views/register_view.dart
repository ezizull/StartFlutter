import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/modules/register/controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  font: 'Roboto',
                  size: 38,
                ),
              ),
              Container(
                height: 50,
                width: 320,
                margin: EdgeInsets.only(bottom: 18),
                child: TextField(
                  controller: controller.emailC,
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
                    contentPadding: EdgeInsets.all(10.0),
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
                margin: EdgeInsets.only(bottom: 18),
                child: TextField(
                  controller: controller.passwC,
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
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(40)),
                  ),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  authC.signup(controller.emailC.text, controller.passwC.text);
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'RobotoCondensed',
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
                margin: EdgeInsets.only(top: 20),
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
        ],
      ),
    );
  }
}
