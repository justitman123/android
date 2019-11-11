import 'dart:convert';

import 'package:bmi_calculator/input_page/loginScreen/googleSignIn/ApiResponse.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:dio/dio.dart';

abstract class BaseAuth {
//  Future<FirebaseUser> googleSignIn();
  Future<void> googleSignIn();
}

class Auth implements BaseAuth {
//  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Response response;
  Dio dio = new Dio();

  @override
  Future<bool> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//    final GoogleSignInAuthentication googleSignInAuthentication =
//        await googleSignInAccount.authentication;

    try {
//    /uaa/auth/signup
      response =
      await new Dio().post("http://192.168.42.4:8060/uaa/auth/mobile",
          data: {
            "displayName": googleSignInAccount.displayName,
            "email": googleSignInAccount.email,
            "photoUrl": googleSignInAccount.photoUrl
          });

      var apiResponse = ApiResponse.fromJson(response.data);

//      FirebaseUser user = await firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ' + e.toString());
      return null;
    }
  }
}
