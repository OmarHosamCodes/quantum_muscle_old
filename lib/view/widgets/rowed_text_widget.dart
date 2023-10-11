import '../../../library.dart';

class RowedText extends StatelessWidget {
  const RowedText({
    super.key,
    this.mainAxisAlignment = MainAxisAlignment.start,
    required this.child,
  });
  final MainAxisAlignment mainAxisAlignment;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [child],
    );
  }
}
