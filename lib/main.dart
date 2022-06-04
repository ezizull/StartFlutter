import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/routes/app_pages.dart';
import 'package:start/app/utilities/loading.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApps());
}

class MyApps extends StatefulWidget {
  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  final authC = Get.put(AuthController(), permanent: true);
  late SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // recive();
  }

  void recive() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      authC.valid.value = preferences.getBool('valid')!;
      authC.id.value = preferences.getString('id')!;
      authC.nim.value = preferences.getString('nim')!;
      authC.nama.value = preferences.getString('nama')!;
      authC.username.value = preferences.getString('username')!;
      authC.password.value = preferences.getString('password')!;
      print(
          '${preferences.getBool('valid')} ${preferences.getString('id')} ${preferences.getString('nim')} ${preferences.getString('nama')} ${preferences.getString('username')} ${preferences.getString('password')} ');
      // print(
      //     '${authC.valid.value}  ${authC.id.value}  ${authC.nim.value} ${authC.nama.value} ${authC.username.value} ${authC.password.value} ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            // print(snapshot.data);
            return Obx(() => GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    fontFamily: 'Roboto',
                  ),
                  initialRoute: authC.valid.value ||
                          snapshot.data != null &&
                              snapshot.data!.emailVerified == true
                      ? Routes.ROOT
                      : Routes.LOGIN,
                  getPages: AppPages.routes,
                ));
          }
          return LoadingView();
        });
  }
}
