import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.onSaved,
    required this.regEx,
    required this.hintText,
    required this.obscureText,
    this.keyboardType = TextInputType.text,
  });

  final Function(String) onSaved;
  final String regEx;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: (value) {
        onSaved(value!);
      },
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
      ),
      obscureText: obscureText,
      validator: (value) {
        return RegExp(regEx).hasMatch(value!) ? null : 'Enter a valid value';
      },
      decoration: InputDecoration(
        fillColor: const Color.fromRGBO(30, 29, 37, 1.0),
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white54,
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
