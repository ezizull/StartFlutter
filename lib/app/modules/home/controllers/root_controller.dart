import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:start/app/modules/home/views/home/collection_view.dart';
import 'package:start/app/modules/home/views/home/discover_view.dart';
import 'package:start/app/modules/home/views/home/videos_view.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:start/app/modules/home/views/home_view.dart';

class RootBarController extends GetxController {
  static RootBarController get to => Get.find<RootBarController>();
  ScrollController scrollHctrl = ScrollController();
  ScrollController scrollVctrl = ScrollController();

  RxDouble scrollh = 0.0.obs;
  RxInt scrollv = 0.obs;
  RxBool filter = false.obs;
  RxInt homeIndex = 0.obs;
  RxInt appIndex = 1.obs;

  RxString id = ''.obs;
  RxString username = ''.obs;

  List photos = [].obs;
  List homes = [
    DiscoverView(),
    VideosView(),
    CollectionView(),
  ];

  void fecthAPI() async {
    try {
      await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=20'),
          headers: {
            'Authorization':
                '563492ad6f91700001000001f277827d3d4546d99cea7b770bbbf482'
          }).then((value) {
        Map pexels = jsonDecode(value.body);
        setPhoto(pexels['photos']);
      });
    } catch (e) {}
  }

  void setPhoto(photos) {
    this.photos = photos;
    update();
  }

  @override
  void onInit() {
    fecthAPI();
    super.onInit();
  }

  void onScrollH(props) {
    scrollh.value = props;
    update();
  }

  void onScrollV(props) {
    scrollv.value = props.toInt();
    update();
  }

  @override
  void dispose() {
    scrollHctrl.dispose();
    super.dispose();
  }
}
