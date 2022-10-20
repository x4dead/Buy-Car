import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_bloc_car/bloc/car_bloc.dart';
import 'package:local_bloc_car/models/cars.model.dart';
import 'package:local_bloc_car/screens/widgets/app_loading_animation.dart';
import 'package:local_bloc_car/theme/Color/app_colors.dart';
part 'widgets/app_button.dart';
part 'widgets/app_text_field.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final modelController = TextEditingController();
  final brandController = TextEditingController();
  final priceController = TextEditingController();
  final yearController = TextEditingController();
  final linkController = TextEditingController();
  final isValidated = ValueNotifier<bool>(false);
  final isCamera = ValueNotifier<bool>(false);
  ImagePicker picker = ImagePicker();
  late XFile? _image;
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorsLightGreen,
        title: const Text('Добавить авто'),
      ),
      body: BlocBuilder<CarBloc, CarStates>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppTextField(
                onChanged: (v) {
                  checkValidation();
                },
                labelText: 'Марка',
                controller: brandController,
                inputRegExp: RegExp('[a-zA-Zа-яА-Я]'),
              ),
              const SizedBox(height: 16),
              AppTextField(
                onChanged: (v) {
                  checkValidation();
                },
                controller: modelController,
                labelText: 'Модель',
                inputRegExp: RegExp('[a-z A-Z а-я А-Я 1-9]'),
              ),
              const SizedBox(height: 16),
              AppTextField(
                onChanged: (v) {
                  checkValidation();
                },
                maxLength: 4,
                controller: yearController,
                labelText: 'Год',
                inputRegExp: RegExp('[0-9]'),
                keyboardTypy: TextInputType.number,
              ),
              const SizedBox(height: 16),
              AppTextField(
                onChanged: (v) {
                  checkValidation();
                },
                maxLength: 10,
                controller: priceController,
                labelText: 'USD',
                inputRegExp: RegExp('[0-9]'),
                keyboardTypy: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ValueListenableBuilder(
                valueListenable: isCamera,
                child: const SizedBox(height: 12),
                builder: (context, __, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: isCamera.value,
                        replacement: AppTextField(
                          onChanged: (v) {
                            checkValidation();
                          },
                          maxLength: 9999999,
                          controller: linkController,
                          labelText: 'Ссылка на изображение',
                          keyboardTypy: TextInputType.url,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 48,
                              child: AppButton(
                                isLoading: false,
                                isValidated: true,
                                title: 'Добавить фото',
                                onPressed: () async {
                                  await ShowBottomSheet(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 48),
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                                image: imageFile != null
                                    ? DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(imageFile!))
                                    : const DecorationImage(
                                        image: NetworkImage(
                                          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Sinnbild_PKW.svg/2560px-Sinnbild_PKW.svg.png',
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      child!,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Switch(
                            value: isCamera.value,
                            onChanged: (value) {
                              isCamera.value = !isCamera.value;
                              clearImages();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.help),
                            tooltip: 'Загрузить фото из галереи',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: BlocConsumer<CarBloc, CarStates>(
                  listener: (context, state) {
                    if (state is CarSuccesState) {
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return ValueListenableBuilder(
                      valueListenable: isValidated,
                      builder: (context, _, __) {
                        return AppButton(
                          title: 'Добавить',
                          isValidated: isValidated.value,
                          isLoading: state is CarLoadingState,
                          onPressed: () {
                            final car = CarModel(
                              url: linkController.text,
                              localImage: imageFile,
                              price: double.parse(priceController.text),
                              marka: brandController.text,
                              model: modelController.text,
                              year: int.parse(yearController.text),
                            );
                            BlocProvider.of<CarBloc>(context)
                                .add(AddCars(car: car));
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<PersistentBottomSheetController<dynamic>> ShowBottomSheet(
      BuildContext context) async {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Stack(
          children: [
            Container(
              height: 200,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 18,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Фото авто',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FloatingActionButton(
                          backgroundColor: Colors.blue,
                          onPressed: () async {
                            _image = await picker.pickImage(
                                source: ImageSource.camera);
                            if (imageFile != null) {
                              imageFile = File(_image!.path);
                              checkValidation();
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {});
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: const Icon(Icons.camera, size: 35),
                        ),
                        FloatingActionButton(
                          backgroundColor: Colors.blue,
                          onPressed: () async {
                            _image = await picker.pickImage(
                                source: ImageSource.gallery);
                            // if (imageFile != null) {
                            imageFile = File(_image!.path);
                            checkValidation();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            setState(() {});
                            // }
                          },
                          child: const Icon(
                            Icons.image,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Камера',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Галерея',
                          style: TextStyle(fontSize: 15),
                        )
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                splashRadius: 30,
                tooltip: 'Закрыть',
                hoverColor: AppColors.colorTransparent,
                splashColor: AppColors.colorBlue,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_rounded,
                  color: AppColors.colorRed,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void checkValidation() {
    if ([
      modelController,
      brandController,
      priceController,
      yearController,
    ].every((e) => e.text.length >= 3)) {
      if (imageFile != null || linkController.text.contains(RegExp(r'[\\]'))) {
        isValidated.value = true;
      } else {
        isValidated.value = false;
      }
    } else {
      isValidated.value = false;
    }
  }

  @override
  void dispose() {
    isValidated.dispose();
    modelController.dispose();
    brandController.dispose();
    priceController.dispose();
    yearController.dispose();
    linkController.dispose();
    super.dispose();
  }

  void clearImages() {
    if (linkController.text.isNotEmpty && imageFile!.path.isNotEmpty) {
      linkController.clear();
    } else {}
  }
}
