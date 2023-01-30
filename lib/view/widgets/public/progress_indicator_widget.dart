import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QFProgressIndicator extends StatelessWidget {
  const QFProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Get.theme.primaryColor,
      strokeWidth: 3.w,
    );
  }
}
