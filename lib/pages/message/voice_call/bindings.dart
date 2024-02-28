import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/pages/message/voice_call/controller.dart';

class VoiceCallViewBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut<VoiceCallController>(() => VoiceCallController());
  }
}