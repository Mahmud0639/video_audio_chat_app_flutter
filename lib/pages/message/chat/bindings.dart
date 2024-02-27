import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/pages/message/chat/controller.dart';

class ChatBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(() => ChatController());
  }
}