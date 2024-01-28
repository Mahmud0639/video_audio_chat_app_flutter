// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-mzb1Ri_HoL4LSmWiRHfpX3llORH6dAM',
    appId: '1:46175816875:web:8c310570ec24b950453bee',
    messagingSenderId: '46175816875',
    projectId: 'flutter-video-audio-chat-fd845',
    authDomain: 'flutter-video-audio-chat-fd845.firebaseapp.com',
    storageBucket: 'flutter-video-audio-chat-fd845.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA2KscoTbFZjXt2F3T8gHY4XtcL5eucNVo',
    appId: '1:46175816875:android:671a76e7733f6b32453bee',
    messagingSenderId: '46175816875',
    projectId: 'flutter-video-audio-chat-fd845',
    storageBucket: 'flutter-video-audio-chat-fd845.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCp1G1Epea1QM78zGlbxHJ9POaGfBqyuZE',
    appId: '1:46175816875:ios:841b144d67335f3e453bee',
    messagingSenderId: '46175816875',
    projectId: 'flutter-video-audio-chat-fd845',
    storageBucket: 'flutter-video-audio-chat-fd845.appspot.com',
    iosBundleId: 'com.example.videoAudioChatFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCp1G1Epea1QM78zGlbxHJ9POaGfBqyuZE',
    appId: '1:46175816875:ios:bdf658559c72a2dd453bee',
    messagingSenderId: '46175816875',
    projectId: 'flutter-video-audio-chat-fd845',
    storageBucket: 'flutter-video-audio-chat-fd845.appspot.com',
    iosBundleId: 'com.example.videoAudioChatFlutter.RunnerTests',
  );
}