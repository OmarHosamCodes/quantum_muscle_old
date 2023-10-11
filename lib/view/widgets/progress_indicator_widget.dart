import '../../../library.dart';

class QFProgressIndicator extends StatelessWidget {
  const QFProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: Get.theme.primaryColor,
      strokeWidth: 3.w,
    );
  }
}
