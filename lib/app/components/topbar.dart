import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/app/screens/root/controllers/root_controller.dart';
import 'package:start/app/screens/root/views/contact_view.dart';

class TopBar extends StatefulWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final contactc = Get.put(ContactController());
    final appc = Get.put(RootBarController());

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
                  font: 'AndersonGrotesk',
                  size: appc.appIndex.value == 0 ? 25 : 23,
                ))),
          ],
        ));
  }
}
