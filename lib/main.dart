import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/routes/pages.dart';
import 'package:video_audio_chat_flutter/common/style/style.dart';
import 'package:video_audio_chat_flutter/global.dart';
import 'package:video_audio_chat_flutter/pages/message/view.dart';

Future<void> main() async{
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context,child)=>GetMaterialApp(
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
