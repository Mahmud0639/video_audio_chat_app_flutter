import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/pages/message/state.dart';
import 'package:get/get.dart';

class MessageController extends GetxController{
  MessageController();

  final state = MessageState();
  void goProfile() async{
     await Get.toNamed(AppRoutes.Profile);//we should use the "await and async" when it would need some time to proceed
  }
}