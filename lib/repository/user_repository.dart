import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignin ?? GoogleSignIn();

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signUp({String email, String password}) async {

//    _showLoadingIndicator(pr);
//    var response =
//    await Dio().post('http://192.168.42.4:8060/uaa/auth/mobile', data: {
//      "userName": _nameController.text.toString(),
//      "password": _passwordController.text.toString(),
//      "email": _emailController.text,
//      "provider": "custom"
//    });
//    OAuthUser oAuthUser = OAuthUser.fromJSON(response.data);
//    FirebaseUser user = await firebaseAuth.currentUser();
//    if (user != null) {
//      userManagement.createUser('123213', <String, dynamic>{
//        'id': '123213',
//        'user_name': _nameController.text.toString(),
//        'email': _emailController.text,
//        'password': oAuthUser.password,
//        'avatar_url': oAuthUser.avatarUrl,
//        'failure_count': oAuthUser.failureCount,
//        'failure_time': oAuthUser.failureTime,
//        'provider': oAuthUser.provider,
//        'registered': oAuthUser.registered.millisecondsSinceEpoch,
//      }).CatchError((e) {
//        print(e.toString());
//      });
//    }
//    pr.hide();
//    _controller.animateToPage(0,
//        duration: Duration(milliseconds: 800), curve: Curves.bounceOut);
//
//
//    return await _firebaseAuth.createUserWithEmailAndPassword(
//      email: email,
//      password: password,
//    );
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

//  Future<bool> isSignedIn() async {
//    final currentUser = await _firebaseAuth.currentUser();
//    return currentUser != null;
//  }

  Future<bool> isSignedIn() async {
    return false;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}
