import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantum_muscle/controller/AuthControllers/signup_controller.dart';
import 'package:quantum_muscle/view/widgets/private/auth/login_widgets.dart';

import '../../../constants/routes_constants.dart';
import '../../../controller/AuthControllers/login_controller.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailAddressController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                SignupConstants.CREATEACCOUNT,
                style: Get.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 60.h,
              ),
              Container(
                height: 1450.h,
                width: 900.w,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20.r,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 50.h, horizontal: 50.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      InfoTextField(
                        hintText: SignupConstants.USERNAME,
                        customController: userNameController,
                        isObscure: false,
                        haveNext: true,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("First Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InfoTextField(
                        hintText: SignupConstants.EMAIL,
                        customController: emailAddressController,
                        isObscure: false,
                        haveNext: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InfoTextField(
                        hintText: SignupConstants.PASSWORD,
                        customController: passwordController,
                        isObscure: true,
                        haveNext: true,
                        validator: (value) {
                          RegExp regex = RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InfoTextField(
                        hintText: SignupConstants.CONFIRMPASSWORD,
                        customController: confirmPasswordController,
                        isObscure: true,
                        haveNext: true,
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 120.h,
                        child: TextButton(
                          onPressed: () {
                            SignupController().signUserUp(
                              emailAddressController.text,
                              passwordController.text,
                              userNameController.text,
                              errorMessage,
                            );
                          },
                          child: Text(SignupConstants.SIGNUP,
                              style: Get.textTheme.bodyMedium),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      const Spacer(),
                      Text(
                        LoginConstants.CONTINUOWITH,
                        style: Get.textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          for (var provider in LogInController().loginProviders)
                            MaterialButton(
                              onPressed: () {},
                              child: Column(
                                children: [
                                  ProvidersSquareAvatar(
                                    child: Icon(
                                      provider.providerIcon!,
                                      color: Get.theme.scaffoldBackgroundColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    provider.providerName!,
                                    style: Get.textTheme.headlineSmall,
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () => Get.toNamed(RoutesConstants.loginPage),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              SignupConstants.AMEMBER,
                              style: Get.textTheme.headlineSmall!.copyWith(),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              SignupConstants.LOGIN,
                              style: Get.textTheme.headlineSmall!.copyWith(
                                  color: Get.theme.colorScheme.secondary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
