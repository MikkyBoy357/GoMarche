import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/view_models/profile_provider.dart';
import 'package:provider/provider.dart';

import '../auth/number_verification.dart';
import '../screens/home/main_screen.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController controller = TextEditingController();

  String verificationCode = "";

  Future<void> tryLoginWithPhone(BuildContext context) async {
    final phoneNumber = '+229${controller.text}';

    if (controller.text.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return NumberVerification(
              phoneNumber: phoneNumber,
            );
          },
        ),
      );

      print("phone: ${phoneNumber}");
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              print('User Logged In');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MainScreen();
                  },
                ),
              );
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print("FAILED =>");
          print(e.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationCode = verificationID;
          print("SENT => $verificationCode");
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          verificationCode = verificationID;
          print("codeAutoRetrievalTimeout => $verificationCode");
          notifyListeners();
        },
        timeout: Duration(minutes: 2),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid Phone Number'),
        ),
      );
    }
  }

  Future<void> veryfyOTP(BuildContext context, String pin) async {
    try {
      print("verificationCode => $verificationCode");
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
          verificationId: verificationCode,
          smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          print('Pass to home');
          print('====>Login Success<====');
          await Provider.of<ProfileProvider>(context, listen: false).makeDoc(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MainScreen();
              },
            ),
          );
        }
      });
    } catch (e) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid OTP')));
      print(e);
    }
  }
}
