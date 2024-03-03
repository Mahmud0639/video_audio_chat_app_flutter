import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_audio_chat_flutter/common/apis/apis.dart';
import 'package:video_audio_chat_flutter/common/entities/entities.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/common/store/store.dart';
import 'package:video_audio_chat_flutter/common/utils/http.dart';
import 'package:video_audio_chat_flutter/common/widgets/toast.dart';
import 'package:video_audio_chat_flutter/pages/frame/sign_in/index.dart';

class SignInController extends GetxController {
  SignInController();

  final state = SignInState();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        //scopes means how you want to login
        'openid'
        //openid is something that it refers to the same password of this account would be used everywhere
      ]
  );

  Future<void> handleSignIn(String type) async {
    //1:Email,2:Google, 3: facebook, 4: apple, 5: phone
    try{
      if (type == 'phone number') {
          if (kDebugMode) {
            print('...you are continuing with phone number...');
          }
      }else if(type=='google'){
        var user = await _googleSignIn.signIn();
        String? displayName = user!.displayName;
        String email = user.email;
        String id = user.id;
        String photoUrl = user.photoUrl??"assets/icons/google.png";

        LoginRequestEntity loginRequestEntity = LoginRequestEntity();
        loginRequestEntity.avatar = photoUrl;
        loginRequestEntity.email = email;
        loginRequestEntity.name = displayName;
        //id is google uid
        loginRequestEntity.open_id = id;
        loginRequestEntity.type = 2;

        asyncPostAllData(loginRequestEntity);

        print('google data saved!');
      }
    }catch(e){
      if (kDebugMode) {
        print('Error message $e');
      }
    }

  }
  asyncPostAllData(LoginRequestEntity loginRequestEntity) async{
      //at first save data in the database, then save in the local storage
   // var response = await HttpUtil().get('api/index');
    //after successfully logged in we need to set login info as true


    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true
    );

   var result =  await UserAPI.Login(params: loginRequestEntity);
   if(result.code==0){//this 0 is matching with the laravel backend code that is also 0
     //as the condition matched so now we can save our user info that is come from the database as response in the local storage of our phone
     await UserStore.to.saveProfile(result.data!);
     EasyLoading.dismiss();
   }else{
     EasyLoading.dismiss();
     toastInfo(msg: "Internet error.");
   }

    //UserStore.to.setIsLogIn = true;
    Get.offAllNamed(AppRoutes.Message);
  }

}