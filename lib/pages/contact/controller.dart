import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/apis/apis.dart';
import 'package:video_audio_chat_flutter/common/entities/contact.dart';
import 'package:video_audio_chat_flutter/common/entities/entities.dart';
import 'package:video_audio_chat_flutter/common/store/store.dart';
import 'package:video_audio_chat_flutter/pages/contact/state.dart';

class ContactController extends GetxController {
  ContactController();

  final state = ContactState();

  //this is my token
  final token = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;

  //onReady() is called after the widget rendered and visible to the user
  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  //contact info is not my info it is other users info
  //without using of the withConverter it would work perfectly but we need
  //object type data so we used here it, if we don't use withConverter then
  //it will return json or map type of data,so to make our work easy and make them
  //as object we should use withConverter()
  Future<void> goChat(ContactItem contactItem) async {
    //whenever any user try to go to the chat page and select a user to talk to him or her then first time then he or she will initiate first time
    //and it will be "from_message" for him or her and the other guy who will go to the chat page and try to chat with him or her then second time
    //then he or she will be "to_message"
    //this is me to other user
    var from_messages = await db
        .collection("message")
        .withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("fromToken", isEqualTo: token)
        .where("toToken", isEqualTo: contactItem.token)
        .get();

    //this other user to me
    var to_message = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .where("fromToken", isEqualTo: contactItem.token).where(
        "toToken", isEqualTo: token).get();

    //first time there are not any messages from and to, so default docs items should be filled up
    if (from_messages.docs.isEmpty && to_message.docs.isEmpty) {
      var profile = UserStore.to.profile;
      var msgData = Msg(
          from_token: profile.token,
          to_token: contactItem.token,
          from_name: profile.name,
          to_name: contactItem.name,
          from_avatar: profile.avatar,
          to_avatar: contactItem.avatar,
          from_online: profile.online,
          to_online: contactItem.online,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0
      );

      //it will return an id for the two users and it would be same through out the all time chatting each other
      var doc_id = await db.collection("message").withConverter(
          //here the toFirestore() makes all the data as json format and send to firestore because firestore only
        //accept json data
          fromFirestore: Msg.fromFirestore, toFirestore: (Msg msg, options)=>msg.toFirestore()).add(msgData);

      //Get.offAllNamed() will removed all the pages from the stack
      Get.toNamed("/chat",parameters: {
        "doc_id":doc_id.id,
        "to_token":contactItem.token??"",
        "to_name": contactItem.name??"",
        "to_avatar": contactItem.avatar??"",
        "to_online": contactItem.online.toString()
      });
    }else{
      /*if(from_messages.docs.first.id.isNotEmpty){
        Get.toNamed("/chat",parameters: {
        "doc_id":from_messages.docs.first.id,
        "to_token":contactItem.token??"",
        "to_name": contactItem.name??"",
        "to_avatar": contactItem.avatar??"",
        "to_online": contactItem.online.toString()
        });
      }*/

      //updated
      if(from_messages.docs.isNotEmpty){
        Get.toNamed("/chat",parameters: {
          "doc_id":from_messages.docs.first.id,
          "to_token":contactItem.token??"",
          "to_name": contactItem.name??"",
          "to_avatar": contactItem.avatar??"",
          "to_online": contactItem.online.toString()
        });
      }
      /*if(to_message.docs.first.id.isNotEmpty){
        Get.toNamed("/chat",parameters: {
          "doc_id":to_message.docs.first.id,
          "to_token":contactItem.token??"",
          "to_name": contactItem.name??"",
          "to_avatar": contactItem.avatar??"",
          "to_online": contactItem.online.toString()
        });
      }*/
      //updated
      if(to_message.docs.isNotEmpty){
        Get.toNamed("/chat",parameters: {
          "doc_id":to_message.docs.first.id,
          "to_token":contactItem.token??"",
          "to_name": contactItem.name??"",
          "to_avatar": contactItem.avatar??"",
          "to_online": contactItem.online.toString()
        });
      }
    }

  }

  asyncLoadAllData() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    state.contactList.clear();
    var result = await ContactAPI.post_contact();
    if (result.code == 0) {
      state.contactList.addAll(result.data!);
    }

    EasyLoading.dismiss();
  }
}
