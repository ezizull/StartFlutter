import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/modules/home/controllers/root_controller.dart';
import 'package:start/app/modules/home/views/camera_view.dart';
import 'package:start/app/modules/home/views/contact_view.dart';
import 'package:start/app/modules/home/views/history_view.dart';
import 'package:start/app/modules/home/views/home_view.dart';

class RootBar extends StatefulWidget {
  const RootBar({Key? key}) : super(key: key);

  @override
  State<RootBar> createState() => _RootBarState();
}

class _RootBarState extends State<RootBar> {
  final contactc = Get.put(ContactController());
  final appc = Get.put(RootBarController());
  final authC = Get.find<AuthController>();

  final pages = [
    const HomeView(),
    const Contact(),
    const CameraVIew(),
    const HistoryView(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('ffffff'),
      body: Stack(
        children: [
          pages[appc.appIndex.value],
          Container(
            alignment: Alignment.bottomCenter,
            child: bottomNavbar(context),
          ),
        ],
      ),
    );
  }

//Check contacts permission
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

  Container bottomNavbar(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 18, right: 15, left: 15),
      decoration: BoxDecoration(
        color: HexColor('2c698d'),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  primary: appc.appIndex.value == 0
                      ? HexColor('ffffff')
                      : HexColor('bad0d0'),
                ),
                child: appc.appIndex.value == 0 && appc.scrollh.value > 185
                    ? Text('TOP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ))
                    : Icon(
                        Icons.home,
                        size: 28,
                      ),
                onPressed: () {
                  setState(() {
                    if (appc.appIndex.value == 0 && appc.scrollh.value > 185) {
                      appc.scrollHctrl.animateTo(0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut);
                    } else {
                      appc.appIndex.value = 0;
                      appc.scrollHctrl = ScrollController(
                          initialScrollOffset: appc.scrollh.value);
                    }
                  });
                },
              )),
          IconButton(
            enableFeedback: false,
            icon: Icon(
                contactc.contcIndex.value == 1 && appc.appIndex.value == 1
                    ? Icons.close
                    : appc.appIndex.value == 1 || contactc.contcIndex.value == 1
                        ? Icons.person_add_alt_sharp
                        : Icons.perm_contact_calendar_rounded,
                size: appc.appIndex.value == 1 ? 28 : 26),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: appc.appIndex.value == 1
                ? HexColor('ffffff')
                : HexColor('bad0d0'),
            onPressed: () async {
              if (contactc.contcIndex.value == 1 && appc.appIndex.value == 1) {
                setState(() {
                  contactc.contcIndex.value = 0;
                });
              } else if (appc.appIndex.value == 1) {
                final PermissionStatus permissionStatus =
                    await _getPermission();
                if (permissionStatus == PermissionStatus.granted) {
                  setState(() {
                    contactc.contcIndex.value = 1;
                  });
                } else {
                  //If permissions have been denied show standard cupertino alert dialog
                  Get.defaultDialog(
                      title: '',
                      titleStyle: TextStyle(fontSize: 0),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
                      content: Container(
                        width: 300,
                        padding: const EdgeInsets.only(
                            right: 20, left: 20, top: 3, bottom: 0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'Permissions Error',
                                style: TextStyle(
                                    fontSize: 18.5,
                                    color: HexColor('272643'),
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                'please enable contacts\npermission in system\nsettings',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: HexColor('272643'),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto'),
                              ),
                            ),
                            TextButton(
                              child: Text('OK',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18)),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        ),
                      ));
                }
              } else {
                setState(() {
                  appc.appIndex.value = 1;
                });
              }
            },
          ),
          IconButton(
            enableFeedback: false,
            icon: Icon(Icons.camera_alt, size: 26),
            color: appc.appIndex.value == 2
                ? HexColor('ffffff')
                : HexColor('bad0d0'),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                appc.appIndex.value = 2;
              });
            },
          ),
          IconButton(
            enableFeedback: false,
            icon: Icon(Icons.location_history_rounded, size: 26),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: appc.appIndex.value == 3
                ? HexColor('ffffff')
                : HexColor('bad0d0'),
            onPressed: () {
              setState(() {
                appc.appIndex.value = 3;
              });
            },
          ),
        ],
      ),
    );
  }
}
