import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/entities/entities.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/common/store/store.dart';
import 'package:video_audio_chat_flutter/pages/message/chat/state.dart';

class ChatController extends GetxController{
  ChatController();

  final state = ChatState();
  late String doc_id;
  final myInputController = TextEditingController();
  //this token is my token who is sending message
  final token = UserStore.to.profile.token;
  //this instance is a singleton
  final db = FirebaseFirestore.instance;

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
      "call_role":"anchor",
      "doc_id": doc_id,
      "to_token":state.to_token.value
    });
  }
 /* displaySnackBar(String messageText, BuildContext context)
  {
    var snackBar = SnackBar(content: Text(messageText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }*/


  void displaySnackBar(String messageText) {
    Get.snackbar(
      "Snackbar Title", // Title
      messageText, // Message
      duration: Duration(seconds: 3), // Duration
    );
  }

  void sendMessage()async{
    String sendContent = myInputController.text;
    if(sendContent.isEmpty){
      displaySnackBar("Content is empty");
      return;
    }

    final content = Msgcontent(
      token: token,
      content: sendContent,
      type: "text",
      addtime: Timestamp.now()
    );

    await db.collection("message").doc(doc_id).collection("msglist")
    //here fromFirestore is like fromJson() and toFirestore is like toJson()
        .withConverter(fromFirestore: Msgcontent.fromFirestore, toFirestore: (Msgcontent msg,options)=>msg.toFirestore())
        .add(content);


    print(sendContent);
    displaySnackBar("$sendContent",);
    //displaySnackBar(sendContent, Get.context!);

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