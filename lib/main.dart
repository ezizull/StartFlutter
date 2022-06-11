import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/routes/app_pages.dart';
import 'package:start/app/services/dio_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
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
  late DioClient dioClient = DioClient();
  final authc = Get.put(AuthController());

  @override
  void initState() {
    login();
    super.initState();
  }

  void login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String prefemail = pref.getString('email')!;
    String prefpass = pref.getString('password')!;

    if (!GetUtils.isNull(prefemail) && !GetUtils.isNull(prefpass)) {
      dioClient.fetchLogin(email: prefemail, password: prefpass);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'AndersonGrotesk',
          ),
          initialRoute: authc.valid.value ? Routes.ROOT : Routes.LOGIN,
          getPages: AppPages.routes,
        ));
  }
}
