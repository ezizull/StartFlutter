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
    return ListView(
      children: [
        TopBar(),
        Center(child: Text("Camera View Page")),
      ],
    );
  }
}
