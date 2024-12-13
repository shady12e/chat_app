import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String massage, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(massage),
      ),
    );
  }