import 'dart:convert';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_audio_chat_flutter/common/apis/apis.dart';
import 'package:video_audio_chat_flutter/common/entities/chat.dart';
import 'package:video_audio_chat_flutter/common/store/store.dart';
import 'package:video_audio_chat_flutter/common/values/server.dart';
import 'package:video_audio_chat_flutter/pages/message/voice_call/state.dart';

class VoiceCallController extends GetxController {
  VoiceCallController();

  final state = VoiceCallState();
  final player = AudioPlayer();

  String appId = APPID;
  final db = FirebaseFirestore.instance;
  final profile_token = UserStore.to.profile.token;
  late final RtcEngine engine;

  ChannelProfileType channelProfileType = ChannelProfileType.channelProfileCommunication;

  @override
  void onInit() {
    super.onInit();
    var data = Get.parameters;
    //now just update the values that is come
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
    state.call_role.value = data['call_role']??"";
    state.doc_id.value = data["doc_id"]??"";
    state.to_token.value = data["to_token"]??"";


    initEngine();
  }

  //Three parts: i.create, ii.initialize(with appId), iii.register
  Future<void> initEngine() async {
    await player.setAsset("assets/Sound_Horizon.mp3");

    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: appId));

    engine.registerEventHandler(RtcEngineEventHandler(
        onError: (ErrorCodeType err, String msg) {
      print('onError: $err, Message: $msg');
    }, onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      print('onConnection: ${connection.toJson()}');

      state.isJoined.value = true;
    },
        //onUserJoined means when the remote user is connected with the call with user(me)
        onUserJoined:
            (RtcConnection connection, int remoteUid, int elapsed) async {
      await player.pause();
    }, onLeaveChannel: (RtcConnection connection, RtcStats stats) {
      print("user left the room.");
      state.isJoined.value = false;
    }, onRtcStats: (RtcConnection connection, RtcStats stats) {
      print(stats.duration);
    }));

    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
        profile: AudioProfileType.audioProfileDefault,
        scenario: AudioScenarioType.audioScenarioGameStreaming);
      await joinChannel();
      if(state.call_role=="anchor"){
        await sendNotification("voice");
       await player.play();
      }
  }

  Future<void> sendNotification(String callType)async{
    CallRequestEntity callRequestEntity = CallRequestEntity();
    callRequestEntity.call_type = callType;
    callRequestEntity.to_token = state.to_token.value;
    callRequestEntity.to_avatar = state.to_avatar.value;
    callRequestEntity.doc_id = state.doc_id.value;
    callRequestEntity.to_name = state.to_name.value;

    var res = await ChatAPI.call_notifications(params: callRequestEntity);
    if(res.code==0){
      print('notification sent successfully.');
    }else{
      print("Could not sent notification any way.");
    }


  }

  Future<void> joinChannel() async{
    await Permission.microphone.request();
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );

    Future<String> getToken() async{
      if(state.call_role.value == "anchor"){
        //this is in my phone to create a unique channel id
         state.channelId.value =  md5.convert(utf8.encode("${profile_token}_${state.to_token}")).toString();
      }else{
        //it is for other person and in his phone
        state.channelId.value = md5.convert(utf8.encode("${state.to_token}_$profile_token")).toString();
      }
      CallTokenRequestEntity callTokenRequestEntity = CallTokenRequestEntity();
      callTokenRequestEntity.channel_name = state.channelId.value;
      var res = await ChatAPI.call_token(params: callTokenRequestEntity);

      if(res.code==0){
        return res.data!;
      }
      return "";
    }

    //we will get the dynamic generated token for calling, because every 24 hours
    //agora temporary token has expired, so our app should take care of this to
    //generate automatically token for call whenever user will make a call
    String token = await getToken();
    if(token.isEmpty){
      EasyLoading.dismiss();
      Get.back();
      return;//we don't want to execute further
    }

    //dynamic generated token and channel Id
    await engine.joinChannel(token: token, channelId: state.channelId.value, uid: 0, options: const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      //channelProfile: channelProfileType
    ));
    EasyLoading.dismiss();
  }

  Future<void> leaveChannel() async{
    EasyLoading.show(
      indicator: const CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true
    );
    await player.pause();
    state.isJoined.value = false;
    EasyLoading.dismiss();
    Get.back();
  }

  Future<void> _dispose() async{
    await player.pause();
    //this is not our created leaveChannel(), it is from agora
    await engine.leaveChannel();
    await engine.release();
    await player.stop();
  }
  @override
  void dispose(){
    _dispose();
    super.dispose();
  }

  @override
  void onClose() {
    _dispose();
    super.onClose();
  }
}
