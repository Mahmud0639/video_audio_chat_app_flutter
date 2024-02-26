import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/routes/names.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:video_audio_chat_flutter/pages/frame/welcome/controller.dart';
import 'package:video_audio_chat_flutter/pages/message/controller.dart';

class MessagePage extends GetView<MessageController> {
  //we used GetView<WelcomeController> to access all the variables from the WelcomeController class
  const MessagePage({super.key});

  Widget _headBar() {
    return Center(
      child: Container(
        width: 320.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 20.h, bottom: 20.h),
        child: Row(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    controller
                        .goProfile(); //"controller" instance is already available for all the controller
                  },
                  child: Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                        color: AppColors.primarySecondaryBackground,
                        borderRadius: BorderRadius.all(Radius.circular(22.h)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1))
                        ]),
                    child: controller.state.head_detail.value.avatar == null
                        ? const Image(
                            image:
                                AssetImage("assets/images/account_header.png"))
                        : const Text("Hi"),
                  ),
                ),
                Positioned(
                    bottom: 5.w,
                    right: 0.w,
                    height: 14.h,
                    child: Container(
                      width: 14.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                          color: AppColors.primaryElementStatus,
                          borderRadius: BorderRadius.all(Radius.circular(12.w)),
                          border: Border.all(
                              width: 2.w, color: AppColors.primaryElementText)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          CustomScrollView(
            //slivers are scrollable and we should use this whenever we need a lazy loading that means lazy appearing list view
            // instead of ListView.builder()
            slivers: [
              SliverAppBar(
                pinned: true,
                //pinned: true means appBar would not be scrollable anymore it will be fixed
                title: _headBar(),
              )
            ],
          ),
          Positioned(
            right: 20.w,
              bottom: 70.w,
              width: 50.w,
              height: 50.h,
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(AppRoutes.Contact);
                },
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  padding: EdgeInsets.all(10.w),
                  decoration:  BoxDecoration(color: AppColors.primaryElement,
                  borderRadius: BorderRadius.all(Radius.circular(40.w)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(1,1)
                    )
                  ]),
                  child: Image.asset("assets/icons/contact.png"),

            ),
          ))
        ],
      ),
    ));
  }
}
