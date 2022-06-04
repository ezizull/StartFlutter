import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/components/topbar.dart';
import 'package:start/app/modules/home/controllers/root_controller.dart';
import 'package:start/app/modules/home/views/home/collection_view.dart';
import 'package:start/app/modules/home/views/home/discover_view.dart';
import 'package:start/app/modules/home/views/home/videos_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final appc = Get.put(RootBarController());

  @override
  void initState() {
    appc.scrollHctrl.addListener(() {
      appc.onScrollH(appc.scrollHctrl.offset);
    });

    appc.scrollVctrl.addListener(() {
      appc.onScrollV(appc.scrollVctrl.offset);
    });

    super.initState();
  }

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void dispose() {
    // dispose the controller
    super.dispose();
  }

  TextStyle topBtnStyle({color = Color}) {
    return TextStyle(
        fontWeight: FontWeight.w500,
        fontFamily: 'RobotoCondensed',
        color: color,
        fontSize: 17);
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;
    double sheight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      controller: appc.scrollHctrl,
      child: Column(children: <Widget>[
        TopBar(),
        Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () => {
                        setState(() => {
                              appc.homeIndex.value = 0,
                              appc.scrollVctrl.animateTo(0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut),
                            }),
                      },
                  child: Obx(
                    () => Text('Discover',
                        style: topBtnStyle(
                            color: (appc.homeIndex.value == 0 &&
                                        appc.scrollv.value <= 200) ||
                                    appc.scrollv.value <= 200
                                ? HexColor('2c698d')
                                : HexColor('acaadd'))),
                  )),
              GestureDetector(
                  onTap: () => {
                        setState(() => {
                              appc.homeIndex.value = 1,
                              appc.scrollVctrl.animateTo(405,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut),
                            }),
                      },
                  child: Obx(
                    () => Text('Videos',
                        style: topBtnStyle(
                            color: (appc.homeIndex.value == 1 &&
                                        (appc.scrollv.value >= 201 &&
                                            appc.scrollv.value <= 610)) ||
                                    (appc.scrollv.value >= 201 &&
                                        appc.scrollv.value <= 610)
                                ? HexColor('2c698d')
                                : HexColor('acaadd'))),
                  )),
              GestureDetector(
                  onTap: () => {
                        setState(() => {
                              appc.homeIndex.value = 2,
                              appc.scrollVctrl.animateTo(812,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInOut),
                            }),
                      },
                  child: Obx(
                    () => Text('Collection',
                        style: topBtnStyle(
                            color: appc.homeIndex.value == 2 &&
                                        appc.scrollv.value >= 610 ||
                                    appc.scrollv.value >= 610
                                ? HexColor('2c698d')
                                : HexColor('acaadd'))),
                  )),
              GestureDetector(
                onTap: () => {
                  setState(() => {appc.filter.value = !appc.filter.value})
                },
                child: Text('Filter',
                    style: topBtnStyle(
                        color: appc.filter.value
                            ? HexColor('2c698d')
                            : HexColor('acaadd'))),
              ),
            ],
          ),
        ),
        GestureDetector(
          onHorizontalDragStart: ((details) => {}),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: appc.scrollVctrl,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      constraints: BoxConstraints(
                        minWidth: swidth,
                      ),
                      child: DiscoverView(
                          photos: appc.photos.isNotEmpty ? appc.photos : [])),
                  Container(
                      constraints: BoxConstraints(
                        minWidth: swidth,
                      ),
                      child: VideosView(
                          photos: appc.photos.isNotEmpty ? appc.photos : [])),
                  Container(
                      constraints: BoxConstraints(
                        minWidth: swidth,
                      ),
                      child: CollectionView(
                          photos: appc.photos.isNotEmpty ? appc.photos : [])),
                ]),
          ),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(),
        ),
      ]),
    );
  }
}

class ImgAssets extends StatelessWidget {
  const ImgAssets({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/pexels/${this.name}.jpg',
      width: 440,
    );
  }
}
