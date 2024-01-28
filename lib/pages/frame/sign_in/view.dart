import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:video_audio_chat_flutter/pages/frame/sign_in/controller.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  Widget _buildLogo(){
    return Container(
      margin: EdgeInsets.only(top: 100.h,bottom: 80.h),
      child: Text("ChattyLiv",textAlign:TextAlign.center,style: TextStyle(fontSize: 34.sp,fontWeight: FontWeight.bold,color:AppColors.primaryText),),
    );
  }
  Widget _buildThirdPartyLogin(String loginType,String logo){
    return GestureDetector(
      onTap: (){
        print('Third party $loginType is clicked');
        controller.handleSignIn('google');
      },
      child: Container(
        width: 295.w,
        height:   44.h,
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0,1)
            )
          ]

        ),
        child: Row(
          mainAxisAlignment: logo == ''?MainAxisAlignment.center:MainAxisAlignment.start,
          children: [
            logo == ''? Container(): Container(
              padding: EdgeInsets.only(left: 40.w,right: 40.w),
              child: Image.asset("assets/icons/$logo.png"),
            ),
            Container(
              child: Text("Sign in with $loginType",style: TextStyle(fontSize: 5.sp,fontWeight: FontWeight.normal,color: AppColors.primaryText),),
            )
          ],
        ),
      ),
    );
  }
  Widget _buildOrWidget(){
    return  Container(
      margin: EdgeInsets.only(top: 20.h,bottom: 35.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              indent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
          const Text("  Or  "),
          Expanded(
            child: Divider(
              endIndent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          )
        ],
      ),
    );
  }
  Widget _buildSignUpWidget(){
    return GestureDetector(
      onTap: (){
        print('...Signup is clicked');
      },
      child: Column(
        children: [
          Text("Already have an account?",textAlign:TextAlign.center,style: TextStyle(fontSize: 4.sp,fontWeight: FontWeight.normal,color: AppColors.primaryText),),
          Text("Sign in here",textAlign:TextAlign.center,style: TextStyle(fontSize: 4.sp,fontWeight: FontWeight.normal,color: AppColors.primaryElement),)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primarySecondaryBackground,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _buildLogo(),
              _buildThirdPartyLogin("Google","google"),
              _buildThirdPartyLogin("Facebook","facebook"),
              _buildThirdPartyLogin("Apple","apple"),
              _buildOrWidget(),
              _buildThirdPartyLogin("phone number",""),
              SizedBox(height: 15.h,),
              _buildSignUpWidget(),
              SizedBox(height: 30.h,)

            ],
          ),
        ),
      ),
    );
  }
}
