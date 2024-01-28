import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/pages/frame/welcome/state.dart';

class WelcomeController extends GetxController{
  WelcomeController();

  final title = "ChattyLiv";//we keep it here because we want
  final state = WelcomeState();

  @override
  void onReady(){
    super.onReady();

    //specially routing things happen here,,like user logged in or not
    //this function is called while the WelcomeController is initialized
    //print('Welcome Controller');
    Future.delayed(const Duration(seconds: 3),()=>Get.offAllNamed(AppRoutes.Message));
  }
}