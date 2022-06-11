import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start/app/screens/root/controllers/root_controller.dart';

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

  @override
  void dispose() {
    // dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double swidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      controller: appc.scrollHctrl,
      child: Column(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 55, bottom: 15),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                  onTap: () => {
                        setState(() => {
                              appc.homeIndex.value = 0,
                              if (appc.scrollVctrl.hasClients)
                                {
                                  appc.scrollVctrl.animateTo(0,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut),
                                }
                            }),
                      },
                  child: Obx(
                    () => Text('Discover',
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            color: (appc.homeIndex.value == 0 &&
                                        appc.scrollv.value <= swidth / 2) ||
                                    appc.scrollv.value <= swidth / 2
                                ? HexColor('2C698D')
                                : HexColor('7CA0B6'))),
                  )),
              GestureDetector(
                  onTap: () => {
                        setState(() => {
                              appc.homeIndex.value = 1,
                              if (appc.scrollVctrl.hasClients)
                                {
                                  appc.scrollVctrl.animateTo(swidth,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut),
                                }
                            }),
                      },
                  child: Obx(
                    () => Text('Videos',
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            color: (appc.homeIndex.value == 1 &&
                                        (appc.scrollv.value >= swidth / 2 &&
                                            appc.scrollv.value <= swidth)) ||
                                    (appc.scrollv.value >= swidth / 2 &&
                                        appc.scrollv.value <=
                                            swidth + swidth / 4)
                                ? HexColor('2C698D')
                                : HexColor('7CA0B6'))),
                  )),
              GestureDetector(
                  onTap: () => {
                        setState(() => {
                              appc.homeIndex.value = 2,
                              if (appc.scrollVctrl.hasClients)
                                {
                                  appc.scrollVctrl.animateTo(swidth * 2,
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.easeInOut),
                                }
                            }),
                      },
                  child: Obx(
                    () => Text('Collection',
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w800,
                            color: appc.homeIndex.value == 2 &&
                                        appc.scrollv.value >=
                                            swidth + swidth / 4 ||
                                    appc.scrollv.value >= swidth + swidth / 4
                                ? HexColor('2C698D')
                                : HexColor('7CA0B6'))),
                  )),
              GestureDetector(
                onTap: () => {
                  setState(() => {appc.filter.value = !appc.filter.value})
                },
                child: Text('Filter',
                    style: TextStyle(
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w800,
                        color: appc.filter.value
                            ? HexColor('2C698D')
                            : HexColor('7CA0B6'))),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: appc.scrollVctrl,
          child: Obx(() => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        constraints: BoxConstraints(
                          minWidth: swidth,
                        ),
                        child: appc.homes[0]),
                    Container(
                        constraints: BoxConstraints(
                          minWidth: swidth,
                        ),
                        child: appc.homes[1]),
                    Container(
                        constraints: BoxConstraints(
                          minWidth: swidth,
                        ),
                        child: appc.homes[2]),
                  ])),
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
