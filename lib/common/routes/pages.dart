
import 'package:flutter/material.dart';


import 'package:get/get.dart';

import '../../pages/frame/welcome/index.dart';
import '../../pages/frame/sign_in/index.dart';
import '../../pages/message/index.dart';
import '../../pages/profile/index.dart';
import '../../pages/contact/index.dart';

import '../middlewares/router_auth.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const WelcomePage(),
      binding: WelcomeBindings(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),

    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),
/*
    GetPage(name: AppRoutes.EmailLogin, page: () => EmailLoginPage(), binding: EmailLoginBinding()),
    GetPage(name: AppRoutes.Register, page: () => RegisterPage(), binding: RegisterBinding()),
    GetPage(name: AppRoutes.Forgot, page: () => ForgotPage(), binding: ForgotBinding()),
    GetPage(name: AppRoutes.Phone, page: () => PhonePage(), binding: PhoneBinding()),
    GetPage(name: AppRoutes.SendCode, page: () => SendCodePage(), binding: SendCodeBinding()),
  */
    GetPage(name: AppRoutes.Contact, page: () => ContactPage(), binding: ContactBinding()),

    GetPage(name: AppRoutes.Message, page: () => const MessagePage(), binding: MessageBinding(),middlewares: [
       RouteAuthMiddleware(priority: 1),
     ],),

    //at first when the ProfilePage is hit then first time ProfileBinding is loaded after successfully loaded the Binding then only go to the ProfilePage
    GetPage(name: AppRoutes.Profile, page: () => const ProfilePage(), binding: ProfileBinding()),
  /*
    //聊天详情
    GetPage(name: AppRoutes.Chat, page: () => ChatPage(), binding: ChatBinding()),

    GetPage(name: AppRoutes.Photoimgview, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),
    GetPage(name: AppRoutes.VoiceCall, page: () => VoiceCallViewPage(), binding: VoiceCallViewBinding()),
    GetPage(name: AppRoutes.VideoCall, page: () => VideoCallPage(), binding: VideoCallBinding()),*/
  ];






}

