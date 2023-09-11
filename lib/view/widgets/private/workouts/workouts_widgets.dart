import '../../../../library.dart';

class QFSuperButton extends StatelessWidget {
  const QFSuperButton({super.key, this.text, this.onTap, this.icon});

  final String? text;
  final void Function()? onTap;
  final IconData? icon;
  @override
  Widget build(BuildContext context) {
    return QFButton(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          const Spacer(),
          Text(
            text!,
            style: Get.textTheme.titleLarge,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
