import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  FlutterSecureStorage storage;

  LocalStorage._privateConstructor(){
    storage = new FlutterSecureStorage();
  }

  static final LocalStorage _instance = LocalStorage._privateConstructor();

  static LocalStorage get instance { return _instance;}
}