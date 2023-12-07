import 'package:flutter/material.dart';
import '../colors.dart';

double boxWidth = 290.0;
double borderRadius = 50.0;
double boxHeight = 48.0; // Define the box height here

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: textFieldColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF27584C).withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      width: boxWidth,
      height: boxHeight, // Use the box height here
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
    );
  }
}
