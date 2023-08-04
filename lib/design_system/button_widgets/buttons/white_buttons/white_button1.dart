import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';

class WhiteButton1 extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const WhiteButton1({
    Key? key,
    required this.label,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 343,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(
              width: 2, // the thickness
              color: Colors.white, // the color of the border
            ),
            textStyle: TextStyle(
              color: Colors.white,
            )
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 20,
            color: MyColors.black1,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
