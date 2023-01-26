import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantum_muscle/controller/AuthControllers/login_controller.dart';
import 'package:quantum_muscle/view/widgets/private/auth/auth_widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),

              // logo
              const Icon(
                EvaIcons.personDoneOutline,
                size: 100,
              ),
              SizedBox(height: 10.h),

              // welcome back, you've been missed!
              Text(
                LoginConstants.WELCOMEBACK,
                style: Get.textTheme.titleSmall,
              ),

              SizedBox(height: 25.h),

              // email textfield
              QFTextField(
                controller: emailAddressController,
                hintText: LoginConstants.EMAIL,
                obscureText: false,
                hasNext: true,
              ),

              SizedBox(height: 30.h),

              // password textfield
              QFTextField(
                controller: passwordController,
                hintText: LoginConstants.PASSWORD,
                obscureText: true,
                hasNext: false,
              ),

              SizedBox(height: 30.h),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Get.toNamed(RoutesConstants.forgetPasswordPage),
                      child: RowedText(
                        mainAxisAlignment: MainAxisAlignment.end,
                        child: Text(
                          LoginConstants.FORGOTPASSWORD,
                          style: Get.textTheme.bodyMedium!,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // log in button
              QFButton(
                text: LoginConstants.LOGIN,
                onTap: () {
                  LogInController().logUserIn(
                    emailAddressController.text,
                    passwordController.text,
                  );
                },
              ),
              SizedBox(height: 50.h),
              const Spacer(),

              // not a member? register now
              GestureDetector(
                onTap: () => Get.toNamed(RoutesConstants.signupPage),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      LoginConstants.NOTAMEMBER,
                      style: Get.textTheme.bodyMedium,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      LoginConstants.REGISTER,
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
