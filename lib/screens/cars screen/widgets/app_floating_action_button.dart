part of '../cars_screen.dart';

class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColors.colorsLightGreen,
      onPressed: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => const CreateScreen(),
            ));
      },
      tooltip: 'Загрузить машину',
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
