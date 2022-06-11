import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:start/app/components/custom_icons.dart';
import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/screens/root/views/contact/addchat_view.dart';
import 'package:start/app/screens/root/views/contact/message_view.dart';

class ContactController extends GetxController {
  static ContactController get to => Get.find<ContactController>();
  late TextEditingController messageC =
      TextEditingController(text: 'Bismillah');

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxInt contcIndex = 0.obs;

  RxList select = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void addSelect(int id) {
    select.add(id);
    // print(select);
    update();
  }

  void removeSelect(int id) {
    select.remove(id);
    update();
  }

  void clearSelect() {
    select.clear();
    update();
  }

  void sendBio({
    int? age,
    String? img,
    String? birth,
    String? about,
    String? gender,
    String? lastname,
    String? username,
    required String firstname,
  }) async {
    CollectionReference bio = firestore.collection('biodata');
    try {
      await bio.add({
        'firstname': firstname,
        'username': username,
        'lastname': lastname,
        'gender': gender,
        'birth': birth,
        'about': about,
        'img': img,
        'age': age,
      });
    } catch (e) {}
  }
}

class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final contactc = Get.put(ContactController());

  final pages = [
    const MessageView(),
    const AddChatView(),
  ];

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        ListView(
          children: [
            Container(
              height: 60,
            ),
            Obx(() => pages[contactc.contcIndex.value]),
            Container(
              height: 100,
            ),
          ],
        ),
        Obx(() {
          return contactc.select.isEmpty
              ? Container(
                  height: sheight / 9.5,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      right: swidth / 45,
                      left: swidth / 45,
                      bottom: sheight / 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: swidth / 15,
                        height: sheight / 30,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            print('onclick');
                          },
                          icon: Icon(
                            Icons.menu_rounded,
                            size: 26,
                            color: HexColor('2c698d'),
                          ),
                        ),
                      ),
                      Container(
                          child: textBar(
                        colors: [HexColor('2c698d')],
                        fontweight: FontWeight.w900,
                        text: 'GalleryHub',
                        font: 'AndersonGrotesk',
                        size: 20,
                      )),
                    ],
                  ))
              : Container(
                  height: sheight / 9.5,
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                      left: swidth / 35,
                      right: swidth / 35,
                      bottom: sheight / 50),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        spacing: swidth / 14,
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            width: swidth / 15,
                            height: sheight / 30,
                            child: IconButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                contactc.clearSelect();
                              },
                              icon: Icon(
                                CustomIcons.cancel_5,
                                size: 19,
                                color: HexColor('2c698d'),
                              ),
                            ),
                          ),
                          Container(
                            width: swidth / 15,
                            height: sheight / 30,
                            padding: EdgeInsets.only(top: sheight / 500),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "${contactc.select.length}",
                              style: TextStyle(
                                fontSize: 19,
                                color: HexColor('2c698d'),
                                fontWeight: FontWeight.w800,
                                fontFamily: 'AndersonGrotesk',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: swidth / 15,
                        height: sheight / 30,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.delete_outline,
                            size: 24,
                            color: HexColor('2c698d'),
                          ),
                        ),
                      ),
                    ],
                  ));
        }),
      ],
    );
  }
}
