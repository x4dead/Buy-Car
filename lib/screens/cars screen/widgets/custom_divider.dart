part of '../cars_screen.dart';

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Divider(color: AppColors.color000000.withOpacity(0.8)),
        const SizedBox(height: 12),
      ],
    );
  }
}
