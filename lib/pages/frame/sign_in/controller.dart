import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_audio_chat_flutter/common/entities/entities.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
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
           loginRequestEntity.open_id = id;
           loginRequestEntity.type = 2;

           asyncPostAllData();

           print('google data saved!');
          }
      }
    }catch(e){
      if (kDebugMode) {
        print('Error message $e');
      }
    }

  }
  asyncPostAllData(){
      Get.offAllNamed(AppRoutes.Message);
  }

}