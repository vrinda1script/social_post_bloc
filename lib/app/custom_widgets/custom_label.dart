import 'package:flutter/material.dart';

class CustomLable extends StatelessWidget {
  const CustomLable({super.key, required this.lable});
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        lable,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
