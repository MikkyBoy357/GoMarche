import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/app_localizations.dart';
import 'package:go_marche/auth/login_screen.dart';
import 'package:go_marche/design_system/colors/colors.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/text_styles/text_styles.dart';
import 'package:go_marche/design_system/widgets/profile_text_field.dart';
import 'package:go_marche/screens/language_screen.dart';
import 'package:go_marche/screens/profile/components/update_location.dart';
import 'package:go_marche/screens/profile/components/update_name.dart';
import 'package:go_marche/screens/profile/components/update_phone_number.dart';
import 'package:go_marche/screens/profile/components/update_store_name.dart';
import 'package:go_marche/view_models/profile_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // String name = '';
  //
  // String phoneNumber = '';
  //
  // String language = '';
  //
  // String location = '';
  //
  // String storeName = '';
  //
  // bool mich = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // makeDoc();
    Provider.of<ProfileProvider>(context, listen: false).getUserProfileData();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProfileProvider>(context, listen: false).getUserProfileData();

    // makeDoc();
    return Consumer<ProfileProvider>(
        builder: (context, ProfileProvider profileProvider, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            AppLocalizations.of(context)!.translate('profile'),
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut().then(
                      (value) => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginScreen();
                          },
                        ),
                      ),
                    );
                print('Log Out');
                // TODO: Implement Logout functionality

                // runApp(new MaterialApp(
                //   home: new LoginScreen(),
                // ));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 15),
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: MyColors.black2,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(Const.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print('Change Language');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpdateName();
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .translate('name'),
                                    style: MyTextStyles.profileTitle,
                                  ),
                                  subtitle: ProfileTextField(
                                    hintText:
                                        profileProvider.userProfileData.name ??
                                            "Name",
                                    onChanged: (value) {
                                      // name = value;
                                      // print('name: $name');
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Change Language');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpdatePhoneNumber();
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .translate('phone_number'),
                                    style: MyTextStyles.profileTitle,
                                  ),
                                  subtitle: ProfileTextField(
                                    hintText: profileProvider
                                            .userProfileData.phoneNumber ??
                                        "Phone Number",
                                    onChanged: (value) {
                                      // phoneNumber = value;
                                      // print('phoneNumber: $phoneNumber');
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Change Language');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LanguageScreen();
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .translate('language'),
                                    style: MyTextStyles.profileTitle,
                                  ),
                                  subtitle: ProfileTextField(
                                    hintText: profileProvider
                                            .userProfileData.language ??
                                        "Language",
                                    onChanged: (value) {
                                      // language = value;
                                      // print('language: $language');
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // print(' here');
                                  var value = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpdateLocation();
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .translate('location'),
                                    style: MyTextStyles.profileTitle,
                                  ),
                                  subtitle: ProfileTextField(
                                    hintText: profileProvider
                                            .userProfileData.location ??
                                        "Location",
                                    onChanged: (value) {
                                      // location = value;
                                      // print('location: $location');
                                    },
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  print('Change Store Name');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return UpdateStoreName();
                                      },
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    AppLocalizations.of(context)!
                                        .translate('store_name'),
                                    style: MyTextStyles.profileTitle,
                                  ),
                                  subtitle: ProfileTextField(
                                    hintText: profileProvider
                                            .userProfileData.storeName ??
                                        "StoreName",
                                    onChanged: (value) {
                                      // storeName = value;
                                      // print('storeName: $storeName');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
        //   child: Button1(
        //     label: AppLocalizations.of(context).translate('update_profile'),
        //     onPressed: () {
        //       if (1 == 1
        //           // name.isNotEmpty &&
        //           //     phoneNumber.isNotEmpty &&
        //           //     language.isNotEmpty &&
        //           //     location.isNotEmpty &&
        //           //     storeName.isNotEmpty
        //           ) {
        //         setState(() {
        //           DocumentReference documentReference = FirebaseFirestore.instance
        //               .collection("users")
        //               .doc(FirebaseAuth.instance.currentUser.uid);
        //           print('=========> RANDOM LOG HAHAHAHAHA');
        //           Map<String, String> categories = {
        //             "name": name,
        //             "phoneNumber": phoneNumber,
        //             "language": language,
        //             "location": location,
        //             "storeName": storeName,
        //           };
        //           print("=======> Firestore Mapping");
        //           print(categories.toString());
        //           documentReference.update(categories).whenComplete(
        //             () {
        //               showDialog(
        //                 context: context,
        //                 builder: (context) {
        //                   return CupertinoAlertDialog(
        //                     title: Text('SUCCESS'),
        //                     content: Text('$name Added Successfully'),
        //                   );
        //                 },
        //               );
        //             },
        //           );
        //         });
        //       } else {
        //         showDialog(
        //           context: context,
        //           builder: (context) {
        //             return CupertinoAlertDialog(
        //               title: Text('Oops!'),
        //               content: Text(
        //                 '\n\n\n\nFields must not be empty',
        //                 style: MyTextStyles.subtitleStyle,
        //               ),
        //             );
        //           },
        //         );
        //         print('=======> Fields must not be empty <=======');
        //       }
        //     },
        //   ),
        // ),
      );
    });
  }
}
