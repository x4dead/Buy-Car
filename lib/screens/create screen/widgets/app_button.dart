part of '../create_screen.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.isValidated,
    required this.isLoading,
    required this.title,
  }) : super(key: key);

  final Function() onPressed;
  final bool isValidated;
  final bool isLoading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: AppColors.colorsLightGreen),
      onPressed: isLoading
          ? null
          : isValidated
              ? onPressed
              : null,
      child: isLoading
          ? const SizedBox(
              height: 14,
              child: AppLoadingAnimation(
                leftDotColor: AppColors.colorGreys,
                rightDotColor: AppColors.colorGrey,
              ),
            )
          : Text(
              title,
              style: const TextStyle(fontSize: 18),
            ),
    );
  }
}
