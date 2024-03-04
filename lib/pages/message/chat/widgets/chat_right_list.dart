import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_audio_chat_flutter/common/entities/entities.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';

Widget ChatRightList(Msgcontent msg) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.w,horizontal: 20.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250.w, minHeight: 40.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.only(top: 10.w,left: 10.w,right: 10.w,bottom: 10.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryElement,
                  borderRadius: BorderRadius.all(Radius.circular(5.w))
                ),
                child: msg.type == "text"
                    ? Text(
                        msg.content!,
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.primaryElementText),
                      )
                    : Text("Image"),
              )
            ],
          ),
        )
      ],
    ),
  );
}
