import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_muscle/constants/routes_constants.dart';
import 'package:quantum_muscle/constants/text_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quantum_muscle/controller/AuthControllers/login_controller.dart';
import 'package:quantum_muscle/view/widgets/private/auth/login_widgets.dart';

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
            children: [
              //upper part
              // const Icon(
              //   EvaIcons.lock,
              //   size: 100,
              // ),
              Text(
                LoginConstants.WELCOMEBACKTOP,
                style: Get.textTheme.headlineLarge,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                LoginConstants.WELCOMEBACKBOTTOM,
                style: Get.textTheme.bodySmall,
              ),
              SizedBox(
                height: 50.h,
              ),
              // end
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
                        hintText: LoginConstants.EMAIL,
                        customController: emailAddressController,
                        isObscure: false,
                        haveNext: true,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InfoTextField(
                        hintText: LoginConstants.PASSWORD,
                        customController: passwordController,
                        isObscure: true,
                        haveNext: false,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: RowedText(
                          mainAxisAlignment: MainAxisAlignment.end,
                          child: Text(
                            LoginConstants.FORGOTPASSWORD,
                            style: Get.textTheme.headlineSmall!,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      SizedBox(
                        width: double.maxFinite,
                        height: 120.h,
                        child: TextButton(
                          onPressed: () {
                            LogInController().logUserIn(
                              emailAddressController.text,
                              passwordController.text,
                            );
                          },
                          child: Text(LoginConstants.LOGIN,
                              style: Get.textTheme.bodyMedium),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        LoginConstants.CONTINUOWITH,
                        style: Get.textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     for (var provider in LogInController().loginProviders)
                      //       MaterialButton(
                      //         onPressed: () {},
                      //         child: Column(
                      //           children: [
                      //             ProvidersSquareAvatar(
                      //               child: Icon(
                      //                 provider.providerIcon!,
                      //                 color: Get.theme.scaffoldBackgroundColor,
                      //               ),
                      //             ),
                      //             SizedBox(
                      //               height: 10.h,
                      //             ),
                      //             Text(
                      //               provider.providerName!,
                      //               style: Get.textTheme.headlineSmall,
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //   ],
                      // ),

                      MaterialButton(
                        onPressed: () => LogInController().signInWithGoogle(),
                        child: Column(
                          children: [
                            ProvidersSquareAvatar(
                              child: Icon(
                                LogInController()
                                    .loginProviders[0]
                                    .providerIcon,
                                color: Get.theme.scaffoldBackgroundColor,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              LogInController().loginProviders[0].providerName!,
                              style: Get.textTheme.headlineSmall,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      const Spacer(),
                      MaterialButton(
                        onPressed: () =>
                            Get.toNamed(RoutesConstants.signupPage),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              LoginConstants.NOTAMEMBER,
                              style: Get.textTheme.headlineSmall!.copyWith(),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              LoginConstants.REGISTER,
                              style: Get.textTheme.headlineSmall!.copyWith(
                                  color: Get.theme.colorScheme.secondary),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
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
