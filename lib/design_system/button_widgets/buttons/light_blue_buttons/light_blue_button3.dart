import 'package:flutter/material.dart';
import 'package:go_marche/design_system/colors/colors.dart';

class LightButton3 extends StatelessWidget {
  final String label;

  const LightButton3({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 143,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            width: 2, // the thickness
            color: MyColors.blue5, // the color of the border
          ),
          textStyle: TextStyle(
            color: MyColors.blue1,
          ),
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
