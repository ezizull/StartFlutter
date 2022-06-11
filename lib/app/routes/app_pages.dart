import 'package:get/get.dart';
import 'package:start/app/screens/root/views/rootbar_view.dart';
import 'package:start/app/screens/login/views/login_view.dart';
import 'package:start/app/screens/login/bindings/login_binding.dart';
import 'package:start/app/screens/register/bindings/register_binding.dart';
import 'package:start/app/screens/register/views/register_view.dart';
import 'package:start/app/screens/repass/bindings/repass_binding.dart';
import 'package:start/app/screens/repass/views/repass_view.dart';

import '../screens/root/bindings/root_binding.dart';

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
