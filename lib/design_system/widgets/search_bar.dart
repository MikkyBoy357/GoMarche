import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final VoidCallback? onPressed;

  const SearchBar({
    Key? key,
    required this.hintText,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        // border: Border.all(color: Colors.grey[200]),
        boxShadow: [
          BoxShadow(
            blurRadius: 60.0,
            spreadRadius: 0.0,
            offset: Offset(0.0, 16.0),
            color: Color(0xff4E4F72).withOpacity(0.08),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextField(
          onTap: onPressed,
          textAlign: TextAlign.left,
          cursorColor: Colors.grey,
          decoration: new InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
            hintText: hintText,
            border: InputBorder.none,
            icon: icon,
          ),
        ),
      ),
    );
  }
}
