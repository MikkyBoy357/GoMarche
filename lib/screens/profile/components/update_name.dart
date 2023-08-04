import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/screens/profile/profile_screen.dart';
import 'package:go_marche/view_models/profile_provider.dart';
import 'package:provider/provider.dart';

class UpdateName extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  'Update your name',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'Your name makes it easy for us to interact with you offline.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    // maxLength: 6,
                    onChanged: (value) {
                      name = value;
                      print('name: $name');
                    },
                    // textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: 'Full Name',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
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
            Provider.of<ProfileProvider>(context, listen: false).updateUserProfileData(context, field: "name", newValue: name);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
