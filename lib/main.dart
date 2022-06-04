import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/app/controllers/auth_controller.dart';
import 'package:start/app/routes/app_pages.dart';
import 'package:start/app/utilities/loading.dart';

import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  importance: Importance.high,
  playSound: true,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

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
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
    getToken();
    // recive();
  }

  void showNotification() {
    setState(() {});
    flutterLocalNotificationsPlugin.show(
        0,
        'title',
        "How you doin ?",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('TheToken: $token');
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
      // print(
      //     '${preferences.getBool('valid')} ${preferences.getString('id')} ${preferences.getString('nim')} ${preferences.getString('nama')} ${preferences.getString('username')} ${preferences.getString('password')} ');
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data != null && snapshot.data!.emailVerified == true) {
              // showNotification();

            }
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
