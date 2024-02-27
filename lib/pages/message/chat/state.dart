import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/entities/entities.dart';

class ChatState{
  RxList<Msgcontent> msgContentList = <Msgcontent>[].obs;

  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var to_online = "".obs;


  RxBool more_status = false.obs;
  //then go to controller class to update the value of toggling process
}