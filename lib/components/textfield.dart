import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.text,
    this.focusNode,
    required this.obscureText,
    required this.controller,
  });
  final String text;
  final bool obscureText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          fillColor: Theme.of(context).colorScheme.background,
          filled: true,
          hintText: text,
          hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
