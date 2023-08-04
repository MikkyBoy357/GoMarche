import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final void Function(String newVal)? onChanged;
  final String hintText;

  const ProfileTextField({
    Key? key,
    this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: false,
      textAlign: TextAlign.start,
      onChanged: onChanged,
      decoration: InputDecoration.collapsed(
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 20,
          color: Colors.grey,
        ),
      ),
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
