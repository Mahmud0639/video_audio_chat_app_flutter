import 'package:flutter/material.dart';
import 'package:video_audio_chat_flutter/common/style/color.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/pages/frame/welcome/controller.dart';

class WelcomePage extends GetView<WelcomeController> {//we used GetView<WelcomeController> to access all the variables from the WelcomeController class
  const WelcomePage({super.key});

  Widget _buildPageHeadTitle(String title){
    return Container(
      margin: EdgeInsets.only(top: 300,left: 30),
      child: Text(title,style: TextStyle(fontSize: 45,color: AppColors.primaryElementText,fontFamily: "Montserrat",fontWeight: FontWeight.bold),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryElement,
      body: Container(
        width: 360,
        height: 780,
        child: _buildPageHeadTitle(controller.title),
      ),
    );
  }
}
