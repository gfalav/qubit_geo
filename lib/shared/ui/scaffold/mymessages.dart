import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qubit_geo/shared/controllers/messages_controller.dart';

class MyMessages extends StatelessWidget {
  const MyMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final MessagesController messagesController = Get.put(MessagesController());

    return Obx(
      () => Padding(
        padding: EdgeInsets.only(right: 6),
        child: Badge(
          backgroundColor:
              messagesController.messages.isNotEmpty
                  ? Colors.red
                  : Colors.transparent,
          label:
              messagesController.messages.isNotEmpty
                  ? Text(messagesController.messages.length.toString())
                  : null,
          child: IconButton(onPressed: () {}, icon: Icon(Icons.notifications)),
        ),
      ),
    );
  }
}
