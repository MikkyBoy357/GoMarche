import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/view_models/profile_provider.dart';
import 'package:provider/provider.dart';

class UpdatePhoneNumber extends StatefulWidget {
  @override
  _UpdatePhoneNumberState createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update your mobile number',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'We will confirm your number by sending you a code.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '+',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      width: 50,
                      child: TextField(
                        // controller: _countryCodeController,
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: '229',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      width: 30,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _phoneNumberController,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[500],
                          ),
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
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Button1(
          label: 'Update',
          onPressed: () {
            final phoneNumber = "+229${_phoneNumberController.text}";
            Provider.of<ProfileProvider>(context, listen: false).updateUserProfileData(context, field: "phoneNumber", newValue: phoneNumber);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
