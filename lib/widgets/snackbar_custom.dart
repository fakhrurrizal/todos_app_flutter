// snackbar_helper.dart
import 'package:flutter/material.dart';

void showGlobalSnackbar(BuildContext context, String message,
    {Color backgroundColor = Colors.green}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    margin:
        const EdgeInsets.only(top: 80, left: 16, right: 16), // Adjusted margin
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
