import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserManagement {
  Firestore firestore = Firestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

   createUser(String uid, Map data) {
     firestore.collection("oauth_users").document(data["uid"]).setData(data);
   }
}