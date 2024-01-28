import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/pages/message/controller.dart';

class MessageBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<MessageController>(() => MessageController());
  }
}