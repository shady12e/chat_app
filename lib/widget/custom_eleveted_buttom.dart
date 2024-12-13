import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomElevatedBottoms extends StatelessWidget {
  CustomElevatedBottoms(
      {required this.textOfElevatedBottom, required this.color , required this.onTap});

  String textOfElevatedBottom;
  Color color;
  Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape:const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: onTap,
      child: Text(
        textOfElevatedBottom,
        style:const TextStyle(
          color: Color(0xff2B475E),
          fontSize: 18,
        ),
      ),
    );
  }
}
