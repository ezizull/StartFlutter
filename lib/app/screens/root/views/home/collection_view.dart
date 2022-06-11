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
      children: [],
    );
  }
}
