import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/pages/message/chat/state.dart';

class ChatController extends GetxController{
  ChatController();

  final state = ChatState();
  late String doc_id;

  void goMore(){
    //if more_status value has 'true' as by default then put 'true' or not then 'false'
    state.more_status.value = state.more_status.value?false:true;
  }

  //audio call method
  void audioCall(){
    //when we would click on the call button from the menu list then
    //we need close all the menu items immediately
    state.more_status.value = false;
    Get.toNamed(AppRoutes.VoiceCall,parameters: {
      "to_name": state.to_name.value,
      "to_avatar":state.to_avatar.value,
      //anchor means host who will make the call
      "call_role":"anchor"
    });
  }


  @override
  void onInit() {
    super.onInit();

    //we are getting here all the parameters data that is sent from contact_controller page
    var data = Get.parameters;
    doc_id = data['doc_id']!;
    state.to_token.value = data['to_token']??"";
    state.to_name.value = data['to_name']??"";
    state.to_avatar.value = data['to_avatar']??"";
    state.to_online.value = data['to_online']??"1";
  }

}