import 'package:flutter/material.dart';
import 'package:start/app/components/topbar.dart';

class CameraVIew extends StatefulWidget {
  const CameraVIew({Key? key}) : super(key: key);

  @override
  State<CameraVIew> createState() => _CameraVIewState();
}

class _CameraVIewState extends State<CameraVIew> {
  @override
  Widget build(BuildContext context) {
    double sheight = MediaQuery.of(context).size.height;

    return ListView(
      children: [
        Container(
            height: sheight, child: Center(child: Text("Camera View Page"))),
      ],
    );
  }
}
