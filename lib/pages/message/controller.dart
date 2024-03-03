import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:video_audio_chat_flutter/common/apis/apis.dart';
import 'package:video_audio_chat_flutter/common/entities/base.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/pages/message/state.dart';
import 'package:get/get.dart';

class MessageController extends GetxController{
  MessageController();

  final state = MessageState();
  void goProfile() async{
     await Get.toNamed(AppRoutes.Profile);//we should use the "await and async" when it would need some time to proceed
  }

  @override
  void onReady() {
    super.onReady();
    firebaseMessagingSetup();
  }

  firebaseMessagingSetup()async{
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print('My fcm token is: $fcmToken');
    if(fcmToken!=null){
        BindFcmTokenRequestEntity bindFcmTokenRequestEntity = BindFcmTokenRequestEntity();
        bindFcmTokenRequestEntity.fcmtoken = fcmToken;

        await ChatAPI.bind_fcmtoken(params: bindFcmTokenRequestEntity);
    }
  }
}