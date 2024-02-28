import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:video_audio_chat_flutter/pages/message/chat/controller.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx(() {
        return Container(
          child: Text(
            "${controller.state.to_name}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Avenir",
                color: AppColors.primaryText),
          ),
        );
      }),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                child: CachedNetworkImage(
                  imageUrl: controller.state.to_avatar.value,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22.w)),
                        image: DecorationImage(
                          image: imageProvider,
                        )),
                  ),
                  errorWidget: (context, url, error) => Image(
                      image: AssetImage("assets/images/account_header.png")),
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
                        color: controller.state.to_online.value == "1"
                            ? AppColors.primaryElementStatus
                            : AppColors.primarySecondaryElementText,
                        border: Border.all(
                            width: 2, color: AppColors.primaryElementText),
                        borderRadius: BorderRadius.all(Radius.circular(12.w))),
                  ))
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
        //to get it workable we need to wrap the SafeArea() with Obx
        //because Obx make the state dynamic and responsive so that every click time
        //we can get(UI) the latest value immediately
      body: Obx(() =>  SafeArea(
        child: Stack(
          children: [
            Positioned(
                bottom: 0.w,
                child: Container(
                  width: 360.w,
                  padding: EdgeInsets.only(left: 20.w,bottom: 10.h,right: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 270.w,
                        padding: EdgeInsets.only(top: 10.h,bottom: 10.h),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primarySecondaryElementText),
                            borderRadius: BorderRadius.circular(5.w)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 220.w,
                              child: TextField(
                                keyboardType: TextInputType.multiline,
                                autofocus: false,
                                decoration: InputDecoration(
                                    hintText: "Message...",
                                    contentPadding: EdgeInsets.only(left: 15.w,top: 0,bottom: 0),
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent
                                        )
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent
                                        )
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent
                                        )
                                    ),
                                    hintStyle: const TextStyle(
                                        color: AppColors.primarySecondaryElementText
                                    )
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){},
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                child: Image.asset("assets/icons/send.png"),
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          //to get it workable we need to wrap the SafeArea() with Obx
                          //because Obx make the state dynamic and responsive so that every click time
                          //we can get the latest value immediately
                          controller.goMore();
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.w,
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius: BorderRadius.circular(40.w),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(1,1)
                                )
                              ]
                          ),
                          child: Image.asset("assets/icons/add.png"),
                        ),
                      )
                    ],
                  ),
                )),
            //by default we set the value false so it will always be hidden state
            controller.state.more_status.value? Positioned(
              right: 20.w,
              bottom: 70.w,
              height: 200.h,
              width: 40.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.w),
                          color: AppColors.primaryBackground,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1,1)
                            )
                          ]
                      ),
                      child: Image.asset("assets/icons/file.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.w),
                          color: AppColors.primaryBackground,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1,1)
                            )
                          ]
                      ),
                      child: Image.asset("assets/icons/photo.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.audioCall();
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.w),
                          color: AppColors.primaryBackground,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1,1)
                            )
                          ]
                      ),
                      child: Image.asset("assets/icons/call.png"),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){},
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.w),
                          color: AppColors.primaryBackground,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: Offset(1,1)
                            )
                          ]
                      ),
                      child: Image.asset("assets/icons/video.png"),
                    ),
                  )
                ],
              ),
            ):Container()
          ],
        ),
      ),)
    );
  }
}
