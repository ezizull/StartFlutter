import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/modules/home/controllers/root_controller.dart';
import 'package:start/app/modules/home/views/contact_view.dart';
import 'package:start/app/routes/app_pages.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  var radius = 26.0;

  @override
  Widget build(BuildContext context) {
    final contactc = Get.put(ContactController());
    final appc = Get.put(RootBarController());
    final authC = Get.find<AuthController>();

    late SharedPreferences preferences;

    return Container(
        height: appc.appIndex.value != 0 ? 100 : 130,
        padding: EdgeInsets.only(
            right: 20, left: 20, top: appc.appIndex.value == 0 ? 50 : 12),
        child: Row(
          mainAxisAlignment: appc.appIndex.value == 1
              ? MainAxisAlignment.end
              : MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Container(
                alignment:
                    appc.appIndex.value != 1 || contactc.contcIndex.value != 1
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                child: textBar(
                  colors: [HexColor('2c698d')],
                  text: 'GalleryHub',
                  font: 'Roboto',
                  size: appc.appIndex.value == 0 ? 25 : 23,
                ))),
            Obx(() => Visibility(
                  child: GestureDetector(
                    onTap: () async {
                      // authC.unvalid();
                      authC.logout();

                      // preferences = await SharedPreferences.getInstance();
                      // setState(() {
                      //   preferences.setBool("valid", false);
                      //   preferences.setString("id", '');
                      //   preferences.setString("nim", '');
                      //   preferences.setString("nama", '');
                      //   preferences.setString("username", '');
                      //   preferences.setString("password", '');
                      //   print(
                      //       '${preferences.getBool('valid')} ${preferences.getString('id')} ${preferences.getString('nim')} ${preferences.getString('nama')} ${preferences.getString('username')} ${preferences.getString('password')} ');
                      // });
                      Get.offAllNamed(Routes.LOGIN);
                    },
                    child: CircleAvatar(
                      radius: radius,
                      backgroundColor: HexColor('2c698d'),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://picsum.photos/200/300?random=1'),
                        backgroundColor: Colors.transparent,
                        radius: radius - 3,
                      ),
                    ),
                  ),
                  visible: appc.appIndex.value == 0,
                )),
          ],
        ));
  }
}
