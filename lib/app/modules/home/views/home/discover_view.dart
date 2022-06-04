import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/modules/home/controllers/root_controller.dart';

class DiscoverView extends StatefulWidget {
  List photos = [];
  DiscoverView({Key? key, this.photos = const []}) : super(key: key);

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            children: widget.photos
                .map((photo) => Container(
                    width: 190,
                    margin: EdgeInsets.only(
                        bottom: widget.photos.indexOf(photo) % 2 == 0 ? 0 : 11),
                    child: widget.photos.indexOf(photo) % 2 == 0
                        ? null
                        : Image.network(photo['src']['medium'])))
                .toList()),
        Column(
            children: widget.photos
                .map((photo) => Container(
                    width: 190,
                    margin: EdgeInsets.only(
                        bottom: widget.photos.indexOf(photo) % 2 == 0 ? 11 : 0),
                    child: widget.photos.indexOf(photo) % 2 == 0
                        ? Image.network(photo['src']['medium'])
                        : null))
                .toList()),
      ],
    );
  }
}
