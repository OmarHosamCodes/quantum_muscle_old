import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantum_muscle/controller/AuthControllers/forget_password_controller.dart';
import '../../widgets/public/button_widget.dart';
import '../../widgets/public/text_field_widget.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});
  final emailAddressController = TextEditingController();
  final newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                ForgetPasswordConstants.FORGOTPASSWORD,
                style: Get.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                ForgetPasswordConstants.NOPROBLEM,
                style: Get.textTheme.bodySmall,
              ),
              SizedBox(height: 25.h),
              const Spacer(),
              GetBuilder<ForgetPasswordController>(
                init: ForgetPasswordController(),
                builder: (controller) => Visibility(
                  visible: !controller.isEmailSent,
                  child: QFTextField(
                    controller: emailAddressController,
                    hintText: ForgetPasswordConstants.ENTEREMAIL,
                    obscureText: false,
                    hasNext: false,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              GetBuilder<ForgetPasswordController>(
                builder: (controller) => Stack(
                  children: [
                    Visibility(
                      visible: !controller.isEmailSent,
                      child: QFButton(
                        text: ForgetPasswordConstants.ENTEREMAIL,
                        onTap: () => controller.increment(
                          email: emailAddressController.text,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.isEmailSent,
                      child: QFButton(
                        text: ForgetPasswordConstants.RESEND,
                        onTap: () => controller.decrement(),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
