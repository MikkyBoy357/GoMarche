import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/view_models/login_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:go_marche/app_localizations.dart';
import 'package:go_marche/auth/login_screen.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/screens/home/main_screen.dart';
import 'package:provider/provider.dart';

class NumberVerification extends StatefulWidget {
  final String phoneNumber;

  const NumberVerification({Key? key, required this.phoneNumber})
      : super(key: key);

  @override
  State<NumberVerification> createState() => _NumberVerificationState();
}

class _NumberVerificationState extends State<NumberVerification> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<LoginProvider>(context, listen: false).tryLoginWithPhone(context);
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    /// Optionally you can use form to validate the Pinput
    return Consumer<LoginProvider>(
        builder: (context, LoginProvider loginProvider, _) {
      return Scaffold(
        body: Form(
          key: formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Please enter the verification code sent to:",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  widget.phoneNumber,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                SizedBox(height: 50),
                Directionality(
                  // Specify direction if desired
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    controller: pinController,
                    focusNode: focusNode,
                    androidSmsAutofillMethod:
                        AndroidSmsAutofillMethod.smsUserConsentApi,
                    listenForMultipleSmsOnAndroid: true,
                    defaultPinTheme: defaultPinTheme,
                    length: 6,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    // validator: (value) {
                    //   return value == '2222' ? null : 'Pin is incorrect';
                    // },
                    // onClipboardFound: (value) {
                    //   debugPrint('onClipboardFound: $value');
                    //   pinController.setText(value);
                    // },
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) async {
                      debugPrint('onCompleted: $pin');
                      loginProvider.veryfyOTP(context, pin);
                    },
                    onChanged: (value) {
                      debugPrint('onChanged: $value');
                    },
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: focusedBorderColor,
                        ),
                      ],
                    ),
                    focusedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    submittedPinTheme: defaultPinTheme.copyWith(
                      decoration: defaultPinTheme.decoration!.copyWith(
                        color: fillColor,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: focusedBorderColor),
                      ),
                    ),
                    errorPinTheme: defaultPinTheme.copyBorderWith(
                      border: Border.all(color: Colors.redAccent),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Button1(
                  label: "Login",
                  onPressed: () {
                    focusNode.unfocus();
                    // formKey.currentState!.validate();
                    loginProvider.veryfyOTP(context, pinController.text);
                  },
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.translate('no_otp'),
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 5.0),
                GestureDetector(
                  child: Text(
                    AppLocalizations.of(context)!.translate('resend_otp'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MyColors.blue1,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
