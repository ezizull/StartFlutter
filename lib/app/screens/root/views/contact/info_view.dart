import 'package:start/app/components/topbar/textbar.dart';
import 'package:start/app/models/friend.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:start/app/screens/root/views/contact_view.dart';
import 'package:start/app/utilities/toCapitalize.dart';

class InfoView extends StatefulWidget {
  Friend friend;
  InfoView({Key? key, required this.friend}) : super(key: key);

  @override
  State<InfoView> createState() => InfoViewState();
}

class InfoViewState extends State<InfoView> {
  final contactc = Get.put(ContactController());
  final int index = 0;

  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;
    double swidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: HexColor('f3f6f5'),
      body: ListView(padding: EdgeInsets.zero, children: [
        Container(
          width: swidth,
          height: sheight / 2.8,
          padding: EdgeInsets.only(top: sheight / 30),
          decoration: BoxDecoration(
              color: HexColor('2c698d'),
              image: DecorationImage(
                  image: NetworkImage(
                    '${widget.friend.imgUrl()}',
                  ),
                  fit: BoxFit.cover,
                  opacity: 0.6)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      right: swidth / 40, left: swidth / 40, top: 20),
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
                            Icons.arrow_back_ios,
                            color: HexColor('ffffff'),
                            size: 22,
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.centerRight,
                          child: textBar(
                            colors: [HexColor('ffffff')],
                            text: 'GalleryHub',
                            font: 'AndersonGrotesk',
                            size: 22,
                          )),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Text(
                      "${toCapitalize(widget.friend.getFullName())}",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                    Text(
                      "${toCapitalize(widget.friend.getUserName())}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
