import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/entities/entities.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/common/store/store.dart';
import 'package:video_audio_chat_flutter/pages/message/chat/state.dart';

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();
  late String doc_id;
  final myInputController = TextEditingController();
  var listen;

  //this token is my token who is sending message
  final token = UserStore.to.profile.token;

  //this instance is a singleton
  final db = FirebaseFirestore.instance;

  void goMore() {
    //if more_status value has 'true' as by default then put 'true' or not then 'false'
    state.more_status.value = state.more_status.value ? false : true;
  }

  //audio call method
  void audioCall() {
    //when we would click on the call button from the menu list then
    //we need close all the menu items immediately
    state.more_status.value = false;
    Get.toNamed(AppRoutes.VoiceCall, parameters: {
      "to_name": state.to_name.value,
      "to_avatar": state.to_avatar.value,
      //anchor means host who will make the call
      "call_role": "anchor",
      "doc_id": doc_id,
      "to_token": state.to_token.value
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

  void sendMessage() async {
    String sendContent = myInputController.text;
    if (sendContent.isEmpty) {
      displaySnackBar("Content is empty");
      return;
    }

    //here we worked some of the query like orderBy,sorting(asc,desc) for learning
    var list = await db.collection("people").add({
      "name": sendContent,
      "age": 29,
      "add_time": Timestamp.now()
    });
    var getSortData = await db.collection("people")
        .orderBy("add_time", descending: true)
        .limit(3).get();

    //we can also like this,but here is a difference of using the get() and snapshots()
    //get() returns us Future type with QuerySnapshot but snapshot returns us Stream type with also QuerySnapshot
    //that means, Stream will show data if the data changes immediately
    var getSortDataAsSnapshot = await db.collection("people")
        .orderBy("add_time", descending: true)
        .limit(3).snapshots();
    //here we will see all the changes immediately realtime
    getSortDataAsSnapshot.listen((event) {
      for (var changes in event.docChanges) {
        switch (changes.type) {
          case DocumentChangeType.added:
            print("...added a document object: ${changes.doc.id}");
            break;
          case DocumentChangeType.modified:
            print("...changed value: ${changes.doc["age"]}");
            break;
          case DocumentChangeType.removed:
            print("...removed will be triggered here.");
            break;
        }
      }
    });

    getSortData.docs.forEach((element) {
      print(element["add_time"]);
    });

    final content = Msgcontent(
        token: token,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now()
    );

    await db.collection("message").doc(doc_id).collection("msglist")
    //here fromFirestore is like fromJson() and toFirestore is like toJson()
        .withConverter(fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options) => msg.toFirestore())
        .add(content).then((DocumentReference doc) {
      print("...Base id is $doc_id and the new message doc id is: ${doc.id}");
      myInputController
          .clear(); //to remove automatically the input text data from the editText
    });

    /* var list = await db.collection("message").get();
    print(list.docs.length);
    var listSub = await db.collection("message").doc(doc_id).collection("msglist").get();
    print(listSub.docs.first.id);
    print(listSub.docs.last.id);

    //for each loop to get all the id
    listSub.docs.forEach((element) {
      print(element.id);
      //if we want to get all the data
      print(element.data());
      //here we are printing only the message that is in the content key(specific)
      print(element.data()["content"]);
    });*/

    //messageResult give us a collection
    var messageResult = await db.collection("message")
        .doc(doc_id)
        .withConverter(fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore())
        .get();

    //to know if we have any unread messages or calls
    //messageResult.data() will give us the specific collection data
    if (messageResult.data() != null) {
      var item = messageResult.data()!;
      int to_msg_num = item.to_msg_num == null ? 0 : item.to_msg_num!;
      int from_msg_num = item.from_msg_num == null ? 0 : item.from_msg_num!;

      if (item.from_token == token) {
        //after sending message it will add automatically with the previous value
        from_msg_num = from_msg_num + 1;
      } else {
        to_msg_num = to_msg_num + 1;
      }

      await db.collection("message").doc(doc_id)
          .update({
        'to_msg_num': to_msg_num,
        'from_msg_num': from_msg_num,
        'last_msg': sendContent,
        'last_time': Timestamp.now()
      });
    }


    print(sendContent);
    displaySnackBar("$sendContent",);
    //displaySnackBar(sendContent, Get.context!);

  }

  @override
  void onReady() {
    super.onReady();
    state.msgContentList.clear();
    final message = db.collection("message").doc(doc_id)
        .collection("msglist").withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg, options) => msg.toFirestore()).orderBy("addtime",descending: true).limit(15);

    listen = message.snapshots().listen((event) {

      List<Msgcontent> tempMsgList = <Msgcontent>[];

      for(var changes in event.docChanges){
        switch(changes.type){
        //it would show us the immediate last message that is added at last
          case DocumentChangeType.added:
            //print(changes.doc.id);
          //it will show the immediate message that is added in the firestore
            tempMsgList.add(changes.doc.data()!);
            break;
          case DocumentChangeType.modified:
            break;
          case DocumentChangeType.removed:
            break;
        }


        tempMsgList.reversed.forEach((element) {
          state.msgContentList.value.insert(0, element);
        });

        state.msgContentList.refresh();


      }

    });

  }
  //now we need to listening realtime everytime when we go back our immediate page
  //unless it will listen all the data again and again
  //with this we can prevent our memory leak
  @override
  //onClose() is more like onDispose() method
  void onClose() {
    super.onClose();
    listen.cancel();
    myInputController.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    //we are getting here all the parameters data that is sent from contact_controller page
    var data = Get.parameters;
    doc_id = data['doc_id']!;
    state.to_token.value = data['to_token'] ?? "";
    state.to_name.value = data['to_name'] ?? "";
    state.to_avatar.value = data['to_avatar'] ?? "";
    state.to_online.value = data['to_online'] ?? "1";
  }

}