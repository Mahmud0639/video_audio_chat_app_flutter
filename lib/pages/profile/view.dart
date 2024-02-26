import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:get/get.dart';

import 'controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  //if here we used Widget instead of AppBar then it will throw an error of Widget error because "appBar" need specific "PreferredWidget" not Widget
  AppBar _buildAppBar(){
    return AppBar(
      title: Text("Profile",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,color: AppColors.primaryText),),
    );
  }

  Widget _buildProfilePhoto(){
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(60.w)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0,1)
              )
            ]
          ),
          child: Image(image: AssetImage("assets/images/account_header.png"),),
        ),
        Positioned(
          bottom: 0.w,
          right: 0.w,
          height: 35.w,
          child: Container(
          width: 35.w,
          height: 35.h,
          padding: EdgeInsets.all(7.w),
          decoration: BoxDecoration(
            color: AppColors.primaryText,
            borderRadius: BorderRadius.all(Radius.circular(40.w))
          ),
            child: Image.asset("assets/images/edit.png",fit: BoxFit.cover,),
        )
        )
      ],
    );
  }

  Widget _buildCompleteBtn(){
    return GestureDetector(
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 60.w,bottom: 30.h) ,
        decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0,1)
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Complete",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.primaryElementText),),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutBtn(){
    return GestureDetector(
      onTap: (){
        Get.defaultDialog(
          title: "Are you sure want to logout?",
          onConfirm: (){
            controller.goLogout();
          },
          onCancel: (){},
          content: Container(),
          textConfirm: "Confirm",
          textCancel: "Cancel"
        );
      },
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 0.w,bottom: 30.h) ,
        decoration: BoxDecoration(
            color: AppColors.primarySecondaryElementText,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0,1)
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logout",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.normal,color: AppColors.primaryElementText),),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            //"SliverToBoxAdapter" is used to use the necessary Container, Row, Column etc. widgets under the slivers
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfilePhoto(),
                    _buildCompleteBtn(),
                    _buildLogoutBtn()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
