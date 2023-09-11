import '../../library.dart';

class ResponsiveController extends StatelessWidget {
  const ResponsiveController(
      {super.key, required this.desktopWidget, required this.mobileWidget});
  final Widget desktopWidget, mobileWidget;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 615) {
          return desktopWidget;
        } else {
          return mobileWidget;
        }
      },
    );
  }
}
