import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';

class Button2 extends StatelessWidget {
  final String label;
  const Button2({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 243,
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
            side: BorderSide(
              width: 2, // the thickness
              color: MyColors.blue1, // the color of the border
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
