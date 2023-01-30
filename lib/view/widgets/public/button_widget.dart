import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QFButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final Widget? child;

  const QFButton({super.key, required this.onTap, this.text, this.child});

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
          child: child ??
              Text(
                text!,
                style: Get.textTheme.titleMedium,
              ),
        ),
      ),
    );
  }
}
