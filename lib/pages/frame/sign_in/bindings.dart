import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/pages/frame/sign_in/controller.dart';

class SignInBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SignInController>(() => SignInController());
  }
}