import 'package:get/get.dart';

class VoiceCallState{
  //isJoined means other user is joined or not with the calling user(me)
  RxBool isJoined = false.obs;
  //other user microphone set to true by default
  RxBool openMicroPhone = true.obs;
  //other user speaker set to true by default
  RxBool enableSpeaker = true.obs;
  RxString callTime = "00:00".obs;
  RxString callStatus = "not connected".obs;

  //every value is set to empty String because we don't know yet what user to be connected
  //and what is his or her basic info
  var to_token = "".obs;
  var to_name = "".obs;
  var to_avatar = "".obs;
  var doc_id = "".obs;
  //audience means receiver, who will receive the call
  var call_role = "audience".obs;
  var channelId = "".obs;
}