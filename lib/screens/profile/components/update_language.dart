import 'package:flutter/material.dart';
import 'package:go_marche/design_system/button_widgets/buttons/blue_buttons/button1.dart';
import 'package:go_marche/design_system/button_widgets/buttons/white_buttons/white_button1.dart';

class UpdateLanguage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Choose your language',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              WhiteButton1(
                label: 'کوردی',
              ),
              WhiteButton1(
                label: 'عربی',
              ),
              Button1(
                label: 'English',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
