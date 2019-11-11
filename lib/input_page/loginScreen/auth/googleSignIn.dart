import 'package:bmi_calculator/input_page/loginScreen/auth/ApiResponse.dart';
import 'package:bmi_calculator/input_page/loginScreen/localstorage/LocalStorage.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
  Future<void> googleSignIn();
}

class Auth implements BaseAuth {
  Response response;
  Dio dio = new Dio();

  @override
  Future<bool> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    await googleSignIn.signOut();

    try {
      response = await new Dio()
          .post("http://192.168.99.1:8060/uaa/auth/mobile", data: {
        "displayName": googleSignInAccount.displayName,
        "email": googleSignInAccount.email,
        "photoUrl": googleSignInAccount.photoUrl
      });

      var apiResponse = ApiResponse.fromJson(response.data);

      if (apiResponse.getAccessToken != null &&
          'Bearer' == apiResponse.getTokenType) {
        await LocalStorage.instance.storage.write(key: 'accessToken', value: apiResponse.getAccessToken);
        await LocalStorage.instance.storage.write(key: 'tokenType', value: apiResponse.getTokenType);
        await LocalStorage.instance.storage.write(key: 'displayName', value: googleSignInAccount.displayName);
        await LocalStorage.instance.storage.write(key: 'email', value: googleSignInAccount.email);
        await LocalStorage.instance.storage.write(key: 'photoUrl', value: googleSignInAccount.photoUrl);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Token getting error');
      return false;
    }
  }
}
