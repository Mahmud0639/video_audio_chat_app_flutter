import 'dart:js';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/entities/contact.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:video_audio_chat_flutter/pages/contact/controller.dart';

class ContactList extends GetView<ContactController> {
  const ContactList({super.key});

  Widget _buildListItem(ContactItem item) {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      decoration: const BoxDecoration(
          //this part is responsible for showing the grey line under the Container
          border: Border(
              bottom: BorderSide(
                  width: 1, color: AppColors.primarySecondaryBackground))),
      child: InkWell(
        onTap: () {
          controller.goChat(item);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                  color: AppColors.primarySecondaryBackground,
                  borderRadius: BorderRadius.all(Radius.circular(22.w)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: CachedNetworkImage(
                imageUrl: item.avatar!,
                height: 44.h,
                width: 44.w,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(22.w)),
                      image: DecorationImage(image: imageProvider)),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.w,left: 10.w,right: 0.w),
              width: 275.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    height: 42.h,
                    child: Text(
                      "${item.name}",
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryThreeElementText,
                        fontFamily: "Avenir"
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.w),
                    width: 12.w,
                    height: 12.h,
                    child: Image.asset("assets/icons/ang.png"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Obx is used to update UI automatically, it comes from GetX
    return Obx(() => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 20.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var item = controller.state.contactList[index];
                    return _buildListItem(item);
                  },
                  childCount: controller.state.contactList.length,
                ),
              ),
            )
          ],
        ));
  }
}
