import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/values/colors.dart';
import 'package:video_audio_chat_flutter/pages/contact/controller.dart';
import 'package:video_audio_chat_flutter/pages/contact/widgets/contact_list.dart';

class ContactPage extends GetView<ContactController> {
  const ContactPage({super.key});

  AppBar _buildAppBar(){
    return AppBar(
      title: Text("Contact",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.normal,color: AppColors.primaryText),),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        width: 360.w,
        height: 780.h,
        child: ContactList(),
      ),
    );
  }
}
