import 'package:flutter/material.dart';

void snackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.red,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: backgroundColor),
  );
}
