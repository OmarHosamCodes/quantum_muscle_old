import '../../../library.dart';

class LoginPage extends HookWidget {
  const LoginPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final emailAddressController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              const Icon(
                EvaIcons.personDoneOutline,
                size: 100,
              ),
              SizedBox(height: 10.h),
              Text(
                LoginConstants.WELCOMEBACK,
                style: Get.textTheme.titleSmall,
              ),
              SizedBox(height: 25.h),
              QFTextField(
                controller: emailAddressController,
                hintText: LoginConstants.EMAIL,
                obscureText: false,
                hasNext: true,
              ),
              SizedBox(height: 30.h),
              QFTextField(
                controller: passwordController,
                hintText: LoginConstants.PASSWORD,
                obscureText: true,
                hasNext: false,
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () =>
                          Get.toNamed(RoutesConstants.FORGETPASSWORDPAGE),
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
              GestureDetector(
                onTap: () {
                  Get.toNamed(RoutesConstants.SIGNUPPAGE);
                },
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
                            .withOpacity(.7),
                      ),
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
