import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFiled extends StatelessWidget {
  CustomTextFiled({
    required this.labelName,
    required this.OnChange,
    required this.validator
  });

  Function(String) OnChange;

  String labelName;
  Function validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        return validator(value);
      },
      onChanged: OnChange,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text(
          labelName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.grey,
        )),
      ),
    );
  }
}
