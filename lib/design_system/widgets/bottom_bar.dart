import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';

import '../../app_localizations.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int index) onTap;
  const BottomBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: MyColors.blue1,
      items: [
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.translate('home'),
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.translate('cart'),
          icon: Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          label: AppLocalizations.of(context)!.translate('profile'),
          icon: Icon(CupertinoIcons.profile_circled),
        ),
      ],
    );
  }
}
