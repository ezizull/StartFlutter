import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/screens/root/controllers/root_controller.dart';
import 'package:start/app/screens/root/views/camera_view.dart';
import 'package:start/app/screens/root/views/contact_view.dart';
import 'package:start/app/screens/root/views/profile_view.dart';
import 'package:start/app/screens/root/views/home_view.dart';

class RootBar extends StatefulWidget {
  const RootBar({Key? key}) : super(key: key);

  @override
  State<RootBar> createState() => _RootBarState();
}

class _RootBarState extends State<RootBar> {
  final authc = Get.find<AuthController>();
  final appc = Get.put(RootBarController());
  final contactc = Get.put(ContactController());

  final pages = [
    const HomeView(),
    const Contact(),
    const CameraVIew(),
    const ProfileView(),
  ];

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
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;

    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 18, right: 50, left: 50),
      decoration: BoxDecoration(
        color: HexColor('ffffff'),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 0), //BoxShadow
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => Container(
                width: swidth / 8,
                child: ElevatedButton(
                  style: ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    surfaceTintColor:
                        MaterialStateProperty.all(Colors.transparent),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    foregroundColor: MaterialStateProperty.all(
                        appc.appIndex.value == 0
                            ? HexColor('272643')
                            : HexColor('5D5D72')),
                  ),
                  child: appc.appIndex.value == 0 && appc.scrollh.value > 75
                      ? Text('TOP',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "AndersonGortesk",
                            fontWeight: FontWeight.w900,
                          ))
                      : Icon(
                          Icons.home,
                          size: 26,
                        ),
                  onPressed: () {
                    setState(() {
                      if (appc.appIndex.value == 0 &&
                          appc.scrollh.value > sheight / 8) {
                        appc.scrollHctrl.animateTo(0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut);
                      } else {
                        if (appc.appIndex.value != 0) {
                          appc.appIndex.value = 0;
                          appc.scrollHctrl = ScrollController(
                              initialScrollOffset: appc.scrollh.value);
                          appc.scrollVctrl = ScrollController(
                              initialScrollOffset:
                                  appc.scrollv.value.toDouble());
                        }
                        appc.appIndex.value = 0;
                      }
                    });
                  },
                ),
              )),
          IconButton(
            enableFeedback: false,
            icon: Icon(
                contactc.contcIndex.value == 1 && appc.appIndex.value == 1
                    ? Icons.close
                    : appc.appIndex.value == 1 || contactc.contcIndex.value == 1
                        ? Icons.person_add_alt_sharp
                        : Icons.perm_contact_calendar_rounded,
                size: appc.appIndex.value == 1 ? 26 : 22),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            color: appc.appIndex.value == 1
                ? HexColor('272643')
                : HexColor('5D5D72'),
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
                      radius: 10,
                      titleStyle: TextStyle(fontSize: 0),
                      contentPadding: EdgeInsets.symmetric(),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
                      content: Container(
                        width: 380,
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        margin: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Permissions Error',
                                    style: TextStyle(
                                        fontSize: 18.5,
                                        color: HexColor('272643'),
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'AndersonGrotesk'),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Container(
                                    height: 30,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                    child: Text(
                                      "OK",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 250,
                              height: 50,
                              margin: EdgeInsets.only(bottom: 0),
                              alignment: Alignment.center,
                              child: Text(
                                'please enable contacts permission in system settings',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: HexColor('272643'),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'AndersonGrotesk'),
                              ),
                            ),
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
            icon: Icon(Icons.camera_alt, size: 24),
            color: appc.appIndex.value == 2
                ? HexColor('272643')
                : HexColor('5D5D72'),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                appc.appIndex.value = 2;
              });
            },
          ),
          GestureDetector(
            onTap: () async {
              authc.logout();
            },
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage('https://picsum.photos/200/300?random=1'),
              backgroundColor: Colors.transparent,
              radius: 13,
            ),
          ),
        ],
      ),
    );
  }
}
