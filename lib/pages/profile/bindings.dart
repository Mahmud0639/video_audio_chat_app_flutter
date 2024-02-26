import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/pages/profile/controller.dart';

class ProfileBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}