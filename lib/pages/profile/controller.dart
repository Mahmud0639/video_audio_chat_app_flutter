import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/common/store/store.dart';
import 'package:video_audio_chat_flutter/pages/profile/index.dart';

class ProfileController extends GetxController{

  ProfileController();

  final title = "ChatLiv";
  final state = ProfileState();


  void goLogout()async{
    await GoogleSignIn().signOut();//signOut is an instance method means not static keyword is available in front of the method name, so to access the method non-static(instance) we need to declare the default constructor of the class then access the instance or general method
    await UserStore.to.onLogout();
  }

}