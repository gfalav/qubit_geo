import 'package:get/get.dart';

class MessagesController extends GetxController {
  final messages = <String>[].obs;

  void addMessage(String message) {
    messages.add(message);
  }
}
