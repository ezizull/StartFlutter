import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:start/app/components/topbar.dart';
import 'package:start/app/modules/home/views/contact/addchat_view.dart';
import 'package:start/app/modules/home/views/contact/message_view.dart';

class ContactController extends GetxController {
  static ContactController get to => Get.find<ContactController>();
  late TextEditingController messageC =
      TextEditingController(text: 'Bismillah');

  RxInt contcIndex = 0.obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
    return ListView(
      children: [
        TopBar(),
        Obx(() => pages[contactc.contcIndex.value]),
        Container(
          height: 100,
        ),
      ],
    );
  }
}
