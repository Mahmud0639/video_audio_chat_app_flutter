import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/routes/pages.dart';
import 'package:video_audio_chat_flutter/common/style/style.dart';
import 'package:video_audio_chat_flutter/global.dart';
import 'package:video_audio_chat_flutter/pages/message/view.dart';

import 'common/utils/FirebaseMassagingHandler.dart';

Future<void> main() async{
  await Global.init();
  runApp(const MyApp());
  firebaseChatInit().then((value) => FirebaseMessagingHandler.config());
}

Future firebaseChatInit()async{
  FirebaseMessaging.onBackgroundMessage(
    FirebaseMessagingHandler.firebaseMessagingBackground
  );

  if(GetPlatform.isAndroid){
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMessagingHandler.channel_call);
    FirebaseMessagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMessagingHandler.channel_message);
  }


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context,child)=>GetMaterialApp(
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      /*theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
      theme: AppTheme.light,
      home: MessagePage(),
      //initialRoute: AppPages.INITIAL,
      //getPages: AppPages.routes,
    ));
  }
}
