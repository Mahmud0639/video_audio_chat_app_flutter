import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:video_audio_chat_flutter/pages/message/chat/controller.dart';

import 'chat_right_list.dart';

class ChatList extends GetView<ChatController> {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      color: AppColors.primaryBackground,
          padding: EdgeInsets.only(bottom: 70.h),
          child: CustomScrollView(
            //this reverse: true is the responsible to show up messages
            //from bottom to top
            reverse: true,
            slivers: [
              SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.w, horizontal: 0.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context,index){
                        var item = controller.state.msgContentList[index];
                        //here identifying the same user token
                        if(controller.token==item.token){
                          return ChatRightList(item);
                        }
                      },
                    childCount: controller.state.msgContentList.length
                  ),
                ),


              ),
            ],
          ),
        ));
  }
}
