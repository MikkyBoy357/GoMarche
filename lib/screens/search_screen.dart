import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';

class Search extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Search',
              style: TextStyle(
                fontSize: 36,
                color: MyColors.black2,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Coming Soon',
                  style: TextStyle(
                    fontSize: 36,
                    color: MyColors.black3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
