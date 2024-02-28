import 'dart:convert';
import 'package:get/get.dart';

import '../entities/user.dart';
import '../routes/names.dart';
import '../services/storage.dart';
import '../values/storage.dart';

class UserStore extends GetxController {
  //This creates a singleton instance of the UserStore class using the GetX package.
  // The Get.find() method is used to retrieve the singleton instance.
  static UserStore get to => Get.find();

  //final _isLogin = false.obs;, _isLogin is declared as a final variable of type observable,
  // typically used in frameworks like Flutter or GetX.
  // This means _isLogin cannot be reassigned to a new instance, but its internal value can change.
  final _isLogin = false.obs;
  // token
  //this is our access_token actually we need to send it with header for Authorization
  String token = '';
  // profile
  final _profile = UserItem().obs;//obs means observable

  bool get isLogin => _isLogin.value;
  //set setIsLogIn(login)=>_isLogin.value = login;
  //we can also like this
  /*set setIsLogIn(var login){
    _isLogin.value = login;
  }*/
  UserItem get profile => _profile.value;
  bool get hasToken => token.isNotEmpty;


  //the main difference between onInit() and onReady() lies in the timing of when they are called in the widget lifecycle.
  // onInit() is called before the widget is rendered,
  // while onReady() is called after the widget is rendered and visible to the user.

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_TOKEN_KEY);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
    if (profileOffline.isNotEmpty) {
      //_isLogin.value = true;, you're modifying the internal value of _isLogin to true.
      // This doesn't violate the immutability of _isLogin because you're not assigning a new instance to _isLogin,
      // you're just modifying its internal state.
      _isLogin.value = true;
      _profile(UserItem.fromJson(jsonDecode(profileOffline)));
    }
  }

  //token
  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    token = value;
  }

  //profile
  Future<String> getProfile() async {
    if (token.isEmpty) return "";
    // var result = await UserAPI.profile();
    // _profile(result);
    // _isLogin.value = true;
   return StorageService.to.getString(STORAGE_USER_PROFILE_KEY);
  }

  //profile
  Future<void> saveProfile(UserItem profile) async {
    _isLogin.value = true;
    //jsonEncode() is used to convert an object into String
    StorageService.to.setString(STORAGE_USER_PROFILE_KEY, jsonEncode(profile));
    _profile(profile);
    setToken(profile.access_token!);
  }


  Future<void> onLogout() async {
   // if (_isLogin.value) await UserAPI.logout();
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    _isLogin.value = false;
    token = '';
    Get.offAllNamed(AppRoutes.SIGN_IN);
  }
}
