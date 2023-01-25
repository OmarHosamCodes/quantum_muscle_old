import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoTextField extends StatelessWidget {
  const InfoTextField(
      {super.key,
      required this.customController,
      required this.isObscure,
      required this.haveNext,
      this.hintText,
      this.validator});
  final TextEditingController customController;
  final bool isObscure;
  final bool haveNext;
  final String? Function(String?)? validator;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
      ),
      obscureText: isObscure,
      controller: customController,
      textInputAction: haveNext ? TextInputAction.next : TextInputAction.done,
      cursorColor: Get.theme.focusColor,
      onSaved: (value) => customController.text = value!,
      validator: validator,
    );
  }
}

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

class ProvidersSquareAvatar extends StatelessWidget {
  const ProvidersSquareAvatar({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      height: 120.h,
      width: 120.w,
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.scaffoldBackgroundColor),
        borderRadius: BorderRadius.circular(20.r),
        shape: BoxShape.rectangle,
        color: Colors.transparent,
      ),
      child: FittedBox(child: child),
    );
  }
}
