import 'dart:ui';
import '../../../library.dart';

class BlurredContainer extends StatelessWidget {
  const BlurredContainer({
    super.key,
    this.child,
    this.padding = const EdgeInsets.all(0),
    this.begin = Alignment.centerLeft,
    required this.borderRadius,
    this.onTap,
  });
  final Widget? child;
  final EdgeInsets padding;
  final AlignmentGeometry begin;
  final BorderRadiusGeometry borderRadius;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 200.h,
        decoration: BoxDecoration(
          color: Get.theme.primaryColor,
          gradient: SweepGradient(
            center: begin,
            colors: [
              Colors.grey.shade400,
              Colors.grey.shade900,
              Colors.grey.shade400,
              Colors.grey.shade900,
              Colors.grey.shade400,
              Colors.grey.shade900,
              Colors.grey.shade400,
              Colors.grey.shade900,
            ],
          ),
          borderRadius: borderRadius,
        ),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
