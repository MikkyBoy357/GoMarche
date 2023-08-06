import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/const.dart';
import 'package:go_marche/design_system/widgets/bottom_bar.dart';
import 'package:go_marche/screens/cart/cart_screen.dart';
import 'package:go_marche/screens/home/components/home_screen.dart';
import 'package:go_marche/screens/profile/profile_screen.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget {
  var cartItemId;
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedItem = 0;
  late String uid;
  PageController _pageController = PageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            _selectedItem = index;
            print(_selectedItem);
          });
        },
        children: [
          HomeScreen(),
          CartScreen(),
          Profile(),
        ],
        controller: _pageController,
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _selectedItem,
        onTap: (index) {
          setState(
            () {
              _selectedItem = index;
              _pageController.animateToPage(_selectedItem,
                  duration: Duration(milliseconds: 200), curve: Curves.linear);
            },
          );
        },
      ),
    );
  }
}
