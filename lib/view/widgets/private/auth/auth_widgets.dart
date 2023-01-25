import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RowedText extends StatelessWidget {
  const RowedText({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.child,
  });
  final MainAxisAlignment mainAxisAlignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [child],
    );
  }
}

/////////////////////////////////////////////////////////////////////////

class QFButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const QFButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: Get.textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////

class QFTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasNext;

  const QFTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.hasNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: Get.textTheme.bodyMedium,
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
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 40.sp),
        ),
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////

