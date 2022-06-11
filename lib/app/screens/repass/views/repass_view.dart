import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/controllers/firebase_auth_controller.dart';
import 'package:start/app/screens/repass/controllers/repass_controller.dart';

class RepassView extends GetView<RepassController> {
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
                height: sheight / 30,
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
                margin: EdgeInsets.only(bottom: sheight / 30),
                child: TextField(
                  controller: controller.emailc,
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
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Send Reset',
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
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I Have an Account',
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'SignIn',
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
