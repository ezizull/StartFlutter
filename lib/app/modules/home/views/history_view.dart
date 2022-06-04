import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/components/topbar.dart';
import 'package:start/app/controllers/auth_controller.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final authC = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        TopBar(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${authC.nama.value}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: HexColor('272643')),
              ),
              Text(
                '${authC.nim.value}',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: HexColor('272643')),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
