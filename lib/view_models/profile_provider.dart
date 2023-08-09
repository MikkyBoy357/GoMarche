import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/widgets/loading_dialog.dart';

import '../design_system/const.dart';
import '../models/UserModel.dart';
import '../screens/home/main_screen.dart';

class ProfileProvider extends ChangeNotifier {
  bool mich = false;
  bool userDataInitialized = false;
  late UserModel userProfileData;

  Future<void> createProfileDoc() async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);
    print('=========> RANDOM LOG HAHAHAHAHA');
    Map<String, dynamic> categories = {
      "name": 'Name',
      "phoneNumber": 'Phone Number',
      "language": 'Language',
      "location": {"latitude": null},
      "storeName": 'StoreName',
    };
    print("=======> Firestore Mapping");
    print(categories.toString());
    await documentReference.set(categories);
  }

  Future<bool> checkExist() async {
    bool exists = false;
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc("${Const.uid}")
          .get()
          .then((doc) {
        if (doc.exists) {
          mich = true;
          exists = true;
        } else {
          exists = false;
        }
      });
      print('OOOOOOO     $mich');
      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> makeDoc(BuildContext context) async {
    print('>>>>UserDocExists?>>>>>${await checkExist()}');
    bool isExist = await checkExist();
    if (await checkExist() == false) {
      print('User Profile document does not exists, let\'s create one 😎');
      await createProfileDoc();
    } else {
      print('User Profile document exists, no need to create one 😎');
    }
    return isExist;
  }

  Future<void> getUserProfileData() async {
    print("====>getUserProfileData<====");
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid);

    DocumentSnapshot<Object?> snapshot = await documentReference.get();
    Object? tempJson = snapshot.data();
    print("==>${tempJson}");
    userProfileData = UserModel.fromJson(tempJson);
    print("==userProfileData==>${userProfileData.toJson()}");
    print("====>getUserProfileData<====");
    userDataInitialized = true;
    notifyListeners();
  }

  Future<void> updateUserProfileData(BuildContext context,
      {required String field, required dynamic newValue}) async {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid);
    print('=========> RANDOM LOG HAHAHAHAHA');
    Map<String, dynamic> categories = {
      field: newValue,
    };
    print("=======> Firestore Mapping");
    print(categories.toString());
    showLoadingDialog(context);
    await documentReference.update(categories).whenComplete(
      () async {
        await showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('SUCCESS'),
              content: Text('$newValue Added Successfully'),
            );
          },
        );
      },
    );

    // get profile data again
    await getUserProfileData();
    Navigator.of(context).pop(context);
  }
}
