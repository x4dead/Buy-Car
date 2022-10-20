part of '../create_screen.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.inputRegExp,
    this.keyboardTypy = TextInputType.text,
    this.maxLength = 20,
    required this.onChanged,
  }) : super(key: key);
  final String labelText;
  final RegExp? inputRegExp;
  final TextEditingController controller;
  final TextInputType keyboardTypy;
  final int maxLength;

  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLength: maxLength,
      keyboardType: keyboardTypy,
      inputFormatters: inputRegExp == null
          ? null
          : [
              FilteringTextInputFormatter.allow(
                inputRegExp!,
              ),
            ],
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        counterText: '',
        suffixIcon: const Icon(Icons.mode_edit_outline_sharp, size: 20),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0.5, color: AppColors.colorBlueAccent),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.8,
            color: AppColors.colorRed,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.8,
            color: AppColors.colorRed,
          ),
        ),
      ),
    );
  }
}
