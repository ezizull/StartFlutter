import 'package:get/get.dart';
import 'package:start/app/models/chat.dart';

class ChatsController extends GetxController {
  RxList<dynamic> users = [].obs;

  @override
  void onInit() {
    super.onInit();
  }

  addChat(Chat chat) {
    users.add(chat);
    update();
  }

  updateChat(Chat chat) {
    update();
  }

  removeChat(Chat chat) {
    users.remove(chat);
    update();
  }
}
