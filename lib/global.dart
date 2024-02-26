import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/services/services.dart';
import 'package:video_audio_chat_flutter/common/store/store.dart';
import 'package:video_audio_chat_flutter/firebase_options.dart';

class Global{
  static Future init() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
    await Get.putAsync<StorageService>(() => StorageService().init());//"Get.putAsync" is used when a method returns a Future type that is awaiting(need to wait an uncertain amount of time)
    Get.put<UserStore>(UserStore());//"Get.put" used to be always ready to use like controller and other things that is needed to be booted up the app, it is always in the memory not removed after any routing
    //"Get.lazyPut" is used only when it is called not for always like the "Get.put" that is the main differences
   await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyA-mzb1Ri_HoL4LSmWiRHfpX3llORH6dAM", appId: "1:46175816875:web:8c310570ec24b950453bee", messagingSenderId: "46175816875", projectId: "flutter-video-audio-chat-fd845")
    );
  }
}