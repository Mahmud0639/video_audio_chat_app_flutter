import 'package:video_audio_chat_flutter/common/entities/entities.dart';
import 'package:get/get.dart';


class MessageState{

  var head_detail = UserItem().obs;//here "obs" means if we do change any of the user data then it would be reactive automatically,"obs is also a getx property"
}