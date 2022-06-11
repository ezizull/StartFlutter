import 'package:get/get.dart';
import '../controllers/repass_controller.dart';

class RepassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepassController>(
      () => RepassController(),
    );
  }
}
