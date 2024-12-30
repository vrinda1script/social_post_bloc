import 'package:flutter/material.dart';

Future<void> customSnackbar(
  context,
  message,
) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
      backgroundColor: Colors.red,
    ),
  );
}
