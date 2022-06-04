import 'package:flutter/material.dart';

class CollectionView extends StatefulWidget {
  List photos = [];
  CollectionView({Key? key, this.photos = const []}) : super(key: key);

  @override
  State<CollectionView> createState() => _CollectionViewState();
}

class _CollectionViewState extends State<CollectionView> {
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
