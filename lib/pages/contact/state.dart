import 'package:get/get.dart';
import 'package:video_audio_chat_flutter/common/entities/contact.dart';

class ContactState {
  RxList<ContactItem> contactList = <ContactItem>[].obs;//obs means observable or reactive, internally value update
}