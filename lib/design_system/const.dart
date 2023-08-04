import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Const {
  static var appLang;
  static var uid = FirebaseAuth.instance.currentUser?.uid;
  static var phoneNumber = FirebaseAuth.instance.currentUser?.phoneNumber;
  static var location;
  static var myCartLength;
  static final cartItemId = "${Const.uid}" + "${DateTime.now().minute}";
  static Future<bool> checkExist() async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance
          .doc("users/${Const.uid}")
          .get()
          .then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }
}
