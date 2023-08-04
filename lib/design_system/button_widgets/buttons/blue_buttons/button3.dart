import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';

class Button3 extends StatelessWidget {
  final String label;
  const Button3({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 143,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(
              width: 2, // the thickness
              color: Colors.deepOrange, // the color of the border
            ),
            textStyle: TextStyle(
              color: Colors.white,
            )
        ),
        onPressed: () {},
        child: Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
