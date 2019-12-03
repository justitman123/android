import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserManagement {
  Firestore firestore = Firestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

//  createUser(String uid, Map data) {
//    database
//        .reference()
//        .child("oauth_users/$uid")
//        .push()
//        .set(data);
//  }

  // here user.uid triggers an id inside the user which should match id of the user document
   createUser(String uid, Map data) {
     firestore.collection("oauth_users").document(data["uid"]).setData(data);
   }
}