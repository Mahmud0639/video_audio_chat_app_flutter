import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:video_audio_chat_flutter/pages/message/voice_call/controller.dart';

class VoiceCallViewPage extends GetView<VoiceCallController> {
  const VoiceCallViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary_bg,
      body: SafeArea(
        child: Obx(() {
          return Container(
            child: Stack(
              children: [
                Positioned(
                    top: 10.h,
                    left: 30.w,
                    right: 30.w,
                    child: Column(
                      children: [
                        Text(
                          controller.state.callTime.value,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryElementText),
                        ),
                        Container(
                          width: 70.w,
                          height: 70.h,
                          margin: EdgeInsets.only(top: 150.h),
                          child:
                              Image.network(controller.state.to_avatar.value),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5.h),
                          child: Text(
                            controller.state.to_name.value,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColors.primaryElementText),
                          ),
                        )
                      ],
                    )),
                Positioned(
                  bottom: 80.h,
                  left: 30.w,
                  right: 30.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 60.w,
                              height: 60.h,
                              padding: EdgeInsets.all(15.w),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.w)),
                                  color: controller.state.openMicroPhone.value
                                      ? AppColors.primaryElementText
                                      : AppColors.primaryText),
                              //if true then will show b_microphone otherwise a_microphone will show
                              child: controller.state.openMicroPhone.value
                                  ? Image.asset("assets/icons/b_microphone.png")
                                  : Image.asset(
                                      "assets/icons/a_microphone.png"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "Microphone",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.primaryElementText,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.state.isJoined.value?controller.leaveChannel():controller.joinChannel();
                            },
                            child: Container(
                              width: 60.w,
                              height: 60.h,
                              padding: EdgeInsets.all(15.w),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.w)),
                                  color: controller.state.isJoined.value
                                      ? AppColors.primaryElementBg
                                      : AppColors.primaryElementStatus),
                              //if true then will show b_microphone otherwise a_microphone will show
                              child: controller.state.isJoined.value
                                  ? Image.asset("assets/icons/a_phone.png")
                                  : Image.asset(
                                      "assets/icons/a_telephone.png"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Text(
                              controller.state.isJoined.value?"Disconnect":"Connect",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.primaryElementText,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 60.w,
                              height: 60.h,
                              padding: EdgeInsets.all(15.w),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.w)),
                                  color: controller.state.enableSpeaker.value
                                      ? AppColors.primaryElementText
                                      : AppColors.primaryText),
                              //if true then will show b_microphone otherwise a_microphone will show
                              child: controller.state.enableSpeaker.value
                                  ? Image.asset("assets/icons/b_trumpet.png")
                                  : Image.asset(
                                      "assets/icons/a_trumpet.png"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "Speaker",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.primaryElementText,
                                fontWeight: FontWeight.normal
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
