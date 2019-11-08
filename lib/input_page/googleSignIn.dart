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
  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;


    try {
      response = await dio.post("http://10.128.249.89:8060/uaa/mobile/signup-login",
          data: {
        "displayName": googleSignInAccount.displayName,
            "email": googleSignInAccount.email,
            "photoUrl": googleSignInAccount.photoUrl
      });
//      FirebaseUser user = await firebaseAuth.signInWithCredential(credential);
      return null;
    } catch (e) {
      print('yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy ' + e.toString());
      return null;
    }
  }
}
