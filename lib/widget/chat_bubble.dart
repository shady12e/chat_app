import 'package:flutter/material.dart';
import 'package:myapp/constans.dart';
import 'package:myapp/model/massage_model.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({super.key, required this.massage});
  final Massage massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(
          massage.massage,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 25,
          left: 16,
          right: 16,
        ),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: KPrimaryAppColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFrind extends StatelessWidget {
  ChatBubbleForFrind({super.key, required this.massage});
  final Massage massage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        child: Text(
          massage.massage,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        padding: const EdgeInsets.only(
          top: 25,
          bottom: 25,
          left: 16,
          right: 16,
        ),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
      ),
    );
  }
}
