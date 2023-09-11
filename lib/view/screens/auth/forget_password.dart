import '../../../library.dart';

class ForgetPasswordPage extends HookWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailAddressController = useTextEditingController();
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
                builder: (controller) => Visibility(
                  visible: controller.isEmailSent,
                  child: QFButton(
                    text: controller.isEmailSent
                        ? ForgetPasswordConstants.RESEND
                        : ForgetPasswordConstants.ENTEREMAIL,
                    onTap: () => controller.resetPassword(
                      email: emailAddressController.text,
                    ),
                  ),
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
