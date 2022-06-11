import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/screens/root/views/home/discover_view.dart';
import 'package:start/app/screens/root/views/home/collection_view.dart';

import 'dart:convert';
import 'package:start/app/screens/root/views/home/videos_view.dart';

class RootBarController extends GetxController {
  ScrollController scrollHctrl = ScrollController();
  ScrollController scrollVctrl = ScrollController();

  final authc = Get.find<AuthController>();

  RxDouble scrollh = 0.0.obs;
  RxInt scrollv = 0.obs;
  RxBool filter = false.obs;
  RxInt homeIndex = 0.obs;
  RxInt appIndex = 1.obs;

  RxString id = ''.obs;
  RxString username = ''.obs;

  List photos = [].obs;
  List videos = [].obs;
  List homes = [
    DiscoverView(),
    VideosView(),
    CollectionView(),
  ].obs;

  @override
  void onInit() {
    photoPexels();
    videoPexels();
    super.onInit();
  }

  void photoPexels() async {
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

  void videoPexels() async {
    try {
      await http.get(
          Uri.parse(
              'https://api.pexels.com/videos/search?query=nature&per_page=20'),
          headers: {
            'Authorization':
                '563492ad6f91700001000001f277827d3d4546d99cea7b770bbbf482'
          }).then((value) {
        Map pexels = jsonDecode(value.body);
        // print(pexels["videos"][0]["image"]);

        setVideo(pexels['videos']);
      });
    } catch (e) {}
  }

  void setPhoto(photos) {
    this.photos = photos;
    homes[0] = DiscoverView(photos: photos);

    update();
  }

  void setVideo(videos) {
    this.videos = videos;
    homes[1] = VideosView(videos: videos);
    update();
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
    scrollVctrl.dispose();
    super.dispose();
  }
}
