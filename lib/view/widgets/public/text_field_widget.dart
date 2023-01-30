import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QFTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasNext;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const QFTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false,
      this.hasNext = true,
      this.keyboardType,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        keyboardType: keyboardType,
        style: Get.textTheme.titleSmall,
        cursorColor: Colors.grey,
        controller: controller,
        obscureText: obscureText,
        textInputAction: hasNext ? TextInputAction.next : TextInputAction.done,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: Get.textTheme.titleSmall,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
