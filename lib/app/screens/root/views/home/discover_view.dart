import 'package:flutter/material.dart';

class DiscoverView extends StatefulWidget {
  List photos = [];
  DiscoverView({Key? key, this.photos = const []}) : super(key: key);

  @override
  State<DiscoverView> createState() => _DiscoverViewState();
}

class _DiscoverViewState extends State<DiscoverView> {
  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            children: widget.photos
                .map((photo) => Container(
                    width: 170,
                    margin: EdgeInsets.only(
                        bottom: widget.photos.indexOf(photo) % 2 == 0 ? 0 : 10),
                    child: widget.photos.indexOf(photo) % 2 == 0
                        ? null
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(swidth / 50),
                            child: Image.network(photo['src']['medium']))))
                .toList()),
        Column(
            children: widget.photos
                .map((photo) => Container(
                    width: 170,
                    margin: EdgeInsets.only(
                        bottom: widget.photos.indexOf(photo) % 2 == 0 ? 10 : 0),
                    child: widget.photos.indexOf(photo) % 2 == 0
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(swidth / 50),
                            child: Image.network(photo['src']['medium']))
                        : null))
                .toList()),
      ],
    );
  }
}
