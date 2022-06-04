import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/models/mapel.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:start/app/modules/home/views/contact_view.dart';
import 'package:start/app/utilities/toCapitalize.dart';

class InfoView extends StatefulWidget {
  const InfoView({Key? key}) : super(key: key);

  @override
  State<InfoView> createState() => InfoViewState();
}

class InfoViewState extends State<InfoView> {
  final contactc = Get.put(ContactController());
  final random = new Random();
  final int index = 0;

  @override
  Widget build(BuildContext context) {
    Map user = ModalRoute.of(context)?.settings.arguments as Map;

    Mapel mapel = new Mapel(
      id: user['id'],
      title: "Pemrograman Mobile X",
      about: ["Instalasi Flutter, Dart, Widget", "Passing Data Flutter"],
      moduls: ["1", "2"],
      present: [random.nextBool(), random.nextBool()],
      grades: [random.nextInt(100), random.nextInt(100)],
    );

    return Scaffold(
      backgroundColor: HexColor('f3f6f5'),
      body: ListView(children: [
        Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 20, left: 20, top: 5),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: HexColor('2c698d'),
                      size: 35,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: textBar(
                      colors: [HexColor('2c698d')],
                      text: 'GalleryHub',
                      font: 'Roboto',
                      size: 22,
                    )),
              ],
            )),
        Container(
          width: 400,
          padding: EdgeInsets.only(top: 40),
          child: Column(
            children: [
              CircleAvatar(
                radius: 115,
                backgroundColor:
                    user["online"] ? HexColor('2fcf70') : HexColor('ff2c2c'),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    '${user["imgUrl"]}',
                  ),
                  backgroundColor: Color.fromARGB(0, 60, 35, 35),
                  radius: 108,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50, top: 30),
                child: Column(
                  children: [
                    Text(
                      "${toCapitalize(user["fullName"])}",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Text(
                      "${toCapitalize(user["userName"])}",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(color: HexColor('ffffff')),
        ),
        Container(
            width: 350,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 70, bottom: 20, left: 10),
                  child: Text(
                    mapel.getTitle(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                for (var i = 0; i < mapel.length(); i++)
                  Modul(
                    title: mapel.getModul(i),
                    about: mapel.getAbout(i),
                    grade: mapel.getGrade(i),
                    present: mapel.getPresent(i),
                  ),
              ],
            )),
      ]),
    );
  }
}

class Modul extends StatelessWidget {
  final String title;
  final String about;
  final String grade;
  final bool present;

  const Modul({
    required this.title,
    required this.about,
    required this.grade,
    required this.present,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370,
      height: 230,
      padding: EdgeInsets.all(25),
      margin: EdgeInsets.only(bottom: 20),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Modul $title",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            about,
            style: TextStyle(fontWeight: FontWeight.w300),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 35,
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Grade: $grade',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 14,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: grade == 'A' || grade == 'B' || grade == 'C'
                        ? HexColor('2fcf70')
                        : HexColor('ff2c2c'),
                    borderRadius: BorderRadius.circular(20)),
              ),
              Container(
                height: 35,
                width: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      present ? 'Present' : 'Not yet',
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: present ? HexColor('2fcf70') : HexColor('cccccc'),
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: Text(
              present ? 'View Attachment' : 'Upload Attachment',
              style: TextStyle(
                  color: present ? HexColor('ff7020') : Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            decoration: BoxDecoration(
                color: present ? HexColor('efefef') : HexColor('ff7020'),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: present ? HexColor('ff7020') : Colors.transparent,
                  width: present ? 1.5 : 0,
                )),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: HexColor('ffffff'),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: HexColor('bae8e8'),
            blurRadius: 4,
            spreadRadius: 0.001,
          )
        ],
      ),
    );
  }
}
