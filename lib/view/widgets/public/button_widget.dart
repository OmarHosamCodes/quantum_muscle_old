import '../../../library.dart';

class QFButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final Widget? child;
  final bool isAnotherOption;

  const QFButton({
    super.key,
    required this.onTap,
    this.text,
    this.child,
    this.isAnotherOption = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: isAnotherOption
              ? Get.theme.primaryColor.withOpacity(.3)
              : Get.theme.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: child ??
              Text(
                text!,
                style: Get.textTheme.titleMedium,
              ),
        ),
      ),
    );
  }
}
