import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';

class Button1 extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const Button1({
    Key? key,
    required this.label,
    required this.onPressed,
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
            color: MyColors.blue1, // the color of the border
          ),
          textStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
