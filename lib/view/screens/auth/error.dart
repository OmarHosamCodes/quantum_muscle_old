import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/text_constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: Column(
        children: [
          Text(
            PublicConstants.ERROR,
            style: Get.textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
