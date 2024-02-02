import 'package:flutter/material.dart';

class BubbleMessages extends StatelessWidget {
  const BubbleMessages({super.key, required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
