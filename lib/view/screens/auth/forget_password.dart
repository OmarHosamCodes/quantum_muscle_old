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
              SizedBox(
                height: 30.h,
              ),
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
              QFTextField(
                controller: emailAddressController,
                hintText: ForgetPasswordConstants.ENTEREMAIL,
                obscureText: false,
                hasNext: false,
              ),
              SizedBox(height: 30.h),
              GetBuilder<ForgetPasswordController>(
                init: ForgetPasswordController(),
                builder: (controller) => QFButton(
                  text: controller.isEmailSent
                      ? controller.countDown.toString()
                      : ForgetPasswordConstants.SENDEMAIL,
                  onTap: () => controller.resetPassword(
                    email: emailAddressController.text,
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
