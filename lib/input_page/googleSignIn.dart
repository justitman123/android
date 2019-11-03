import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth {
//  Future<FirebaseUser> googleSignIn();
  Future<void> googleSignIn();
}

class Auth implements BaseAuth {
//  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> googleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    GoogleSignIn _googleSignIn = new GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) async {
    if (account != null) {
    // user logged
    } else {
    // user NOT logged
    }
    });
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleSignInAuthentication.idToken,
//        accessToken: googleSignInAuthentication.accessToken);

    try {
//      FirebaseUser user = await firebaseAuth.signInWithCredential(credential);
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
