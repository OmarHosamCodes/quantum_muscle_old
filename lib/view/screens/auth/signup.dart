import 'package:email_validator/email_validator.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constants/text_constants.dart';
import '../../../controller/auth/signup_controller.dart';
import '../../widgets/public/button_widget.dart';
import '../../widgets/public/text_field_widget.dart';

class SignupPage extends HookWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final userNameController = useTextEditingController();
    final emailAddressController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Form(
        key: formKey,
        child: SafeArea(
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
                  validator: (username) =>
                      username!.length < 4 ? SignupConstants.USERNAME : null,
                ),

                SizedBox(height: 30.h),

                // password textfield
                QFTextField(
                  controller: emailAddressController,
                  hintText: SignupConstants.EMAIL,
                  obscureText: false,
                  hasNext: true,
                  validator: (email) => !EmailValidator.validate(email!)
                      ? SignupConstants.VALIDEMAIL
                      : null,
                ),
                SizedBox(height: 30.h),

                QFTextField(
                  controller: passwordController,
                  hintText: SignupConstants.PASSWORD,
                  obscureText: true,
                  hasNext: false,
                  validator: (password) =>
                      password!.length < 6 ? SignupConstants.PASSWORD : null,
                ),
                SizedBox(height: 30.h),

                // log in button
                QFButton(
                  text: SignupConstants.SIGNUP,
                  onTap: () => SignupController().signUserUp(
                      emailAddressController.text,
                      passwordController.text,
                      userNameController.text,
                      formKey),
                ),
                SizedBox(height: 50.h),
                const Spacer(),
                // not a member? register now
                GestureDetector(
                  onTap: () => Get.toNamed(RoutesConstants.LOGINPAGE),
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
      ),
    );
  }
}
