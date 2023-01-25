import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/routes_constants.dart';
import '../../../constants/text_constants.dart';
import '../../../controller/AuthControllers/signup_controller.dart';
import '../../widgets/private/auth/auth_widgets.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final userNameController = TextEditingController();

  final emailAddressController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              // logo
              const Icon(
                EvaIcons.personOutline,
                size: 100,
              ),
              SizedBox(height: 10.h),

              // welcome back, you've been missed!
              Text(
                SignupConstants.CREATEACCOUNT,
                style: Get.textTheme.titleSmall,
              ),
              SizedBox(height: 25.h),

              QFTextField(
                controller: userNameController,
                hintText: SignupConstants.USERNAME,
                obscureText: false,
                hasNext: true,
              ),

              SizedBox(height: 30.h),

              // password textfield
              QFTextField(
                controller: emailAddressController,
                hintText: SignupConstants.EMAIL,
                obscureText: false,
                hasNext: true,
              ),
              SizedBox(height: 30.h),

              QFTextField(
                controller: passwordController,
                hintText: SignupConstants.PASSWORD,
                obscureText: true,
                hasNext: false,
              ),
              SizedBox(height: 30.h),

              // log in button
              QFButton(
                text: SignupConstants.SIGNUP,
                onTap: () => SignupController().signUserUp(
                  emailAddressController.text,
                  passwordController.text,
                  userNameController.text,
                  errorMessage,
                ),
              ),
              SizedBox(height: 50.h),
              const Spacer(),
              // not a member? register now
              GestureDetector(
                onTap: () => Get.toNamed(RoutesConstants.loginPage),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      SignupConstants.AMEMBER,
                      style: Get.textTheme.bodyMedium,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      SignupConstants.LOGIN,
                      style: Get.textTheme.bodyMedium!.copyWith(
                          color: Get.textTheme.bodyMedium!.color!
                              .withAlpha(5)
                              .withOpacity(.7)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }
}
