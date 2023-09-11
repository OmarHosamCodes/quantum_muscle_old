import '../../../library.dart';

class QFTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final bool hasNext;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool isExpanded;
  final String? initialValue;

  const QFTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.hasNext = true,
    this.keyboardType,
    this.validator,
    this.isExpanded = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    TextInputAction finalInputAction() {
      if (isExpanded) {
        return TextInputAction.newline;
      }
      if (hasNext) {
        return TextInputAction.next;
      } else {
        return TextInputAction.done;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        smartDashesType: SmartDashesType.enabled,
        smartQuotesType: SmartQuotesType.enabled,
        expands: isExpanded,
        keyboardType: keyboardType,
        style: Get.textTheme.titleSmall,
        textAlignVertical: TextAlignVertical.top,
        maxLines: isExpanded ? null : 1,
        cursorColor: Colors.grey,
        controller: controller,
        obscureText: obscureText,
        textInputAction: finalInputAction(),
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: Get.textTheme.titleSmall,
        ),
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
      ),
    );
  }
}
