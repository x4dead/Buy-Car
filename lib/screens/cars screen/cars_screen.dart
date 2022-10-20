import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_bloc_car/bloc/car_bloc.dart';
import 'package:local_bloc_car/models/cars.model.dart';
import 'package:local_bloc_car/theme/Color/app_colors.dart';
import 'package:local_bloc_car/theme/TextStyle/app_text_style.dart';
import '../create screen/create_screen.dart';
import '../widgets/app_loading_animation.dart';

part 'widgets/car_item.dart';
part 'widgets/custom_divider.dart';
part 'widgets/app_bar.dart';
part 'widgets/app_floating_action_button.dart';

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      floatingActionButton: const AppFloatingActionButton(),
      body: BlocBuilder<CarBloc, CarStates>(
        builder: (context, state) {
          if (state is CarLoadingState) {
            return const AppLoadingAnimation(
              leftDotColor: AppColors.colorBlue,
              rightDotColor: AppColors.colorsLightGreen,
            );
          }
          if (state is CarSuccesState) {
            return ListView.separated(
              separatorBuilder: (context, index) => const _CustomDivider(),
              itemCount: state.cars.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) => _CarItem(
                model: state.cars[index],
              ),
            );
          }
          if (state is CarErrorState) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://static.thenounproject.com/png/293805-200.png',
                    scale: 1.8,
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Извините, по вашему запросу\nничего не найдено',
                    style: AppTextStyle.w50018,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Список пуст, загрузите данные!',
                    style: AppTextStyle.w50018),
                const SizedBox(height: 12),
                Image.network(
                  'https://static.thenounproject.com/png/293805-200.png',
                  scale: 1.8,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
