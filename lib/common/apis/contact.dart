import '../entities/contact.dart';
import '../utils/http.dart';

class ContactAPI {
  /// refresh
  /// here we see that we didn't pass any data like toJson()
  /// contact data is checking in the middleware with the Authorization
  /// header and so we didn't send any data to the server with the post method
  static Future<ContactResponseEntity> post_contact() async {
    var response = await HttpUtil().post(
      'api/contact',
    );
    return ContactResponseEntity.fromJson(response);
  }


}
