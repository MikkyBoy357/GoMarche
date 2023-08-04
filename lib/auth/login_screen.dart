import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/view_models/login_provider.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';
import 'number_verification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, LoginProvider loginProvider, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.translate('mobile_number'),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Container(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        child: TextField(
                          controller: loginProvider.countryCodeController,
                          maxLength: 4,
                          keyboardType: TextInputType.number,
                          enabled: false,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: '+229',
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey[500]),
                          ),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        width: 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: loginProvider.controller,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: AppLocalizations.of(context)!
                                .translate('phone_number'),
                            hintStyle:
                                TextStyle(fontSize: 18, color: Colors.grey[500]),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                  ),
                  Button1(
                    label: 'Next',
                    onPressed: () {
                      loginProvider.tryLoginWithPhone(context);
                    },
                  )
                ],
              ),
            ),
          ),
          // bottomNavigationBar: Padding(
          //   padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
          //   child: Row(
          //     children: [
          //       GestureDetector(
          //         child: Text(
          //           'Click here ',
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //             color: MyColors.blue1,
          //           ),
          //         ),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) {
          //                 return NumberVerification();
          //               },
          //             ),
          //           );
          //         },
          //       ),
          //       Text(
          //         'to register if you are new to go_marche',
          //         style: TextStyle(
          //           fontSize: 16,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        );
      }
    );
  }
}
