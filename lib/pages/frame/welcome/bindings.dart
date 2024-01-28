import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/pages/frame/welcome/controller.dart';

//when the app boot up first then the WelcomeBindings class is called and also its methods
//We need to have our controller in memory so we use this dependencies injection system
class WelcomeBindings implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<WelcomeController>(() => WelcomeController());
  }

}