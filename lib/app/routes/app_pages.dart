import 'package:get/get.dart';
import 'package:start/app/modules/home/views/contact/chat_view.dart';
import 'package:start/app/modules/home/views/contact/info_view.dart';
import 'package:start/app/modules/home/views/rootbar_view.dart';
import 'package:start/app/modules/login/views/login_view.dart';
import 'package:start/app/modules/login/bindings/login_binding.dart';
import 'package:start/app/modules/register/bindings/register_binding.dart';
import 'package:start/app/modules/register/views/register_view.dart';
import 'package:start/app/modules/repass/bindings/repass_binding.dart';
import 'package:start/app/modules/repass/views/repass_view.dart';

import '../modules/home/bindings/root_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ROOT;

  static final routes = [
    GetPage(
      name: _Paths.ROOT,
      page: () => RootBar(),
      binding: RootBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.REPASS,
      page: () => RepassView(),
      binding: RepassBinding(),
    ),
  ];
}
