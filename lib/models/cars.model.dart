import 'dart:io';

class CarModel {
  final String? url;
  final File? localImage;
  final double price;
  final String marka;
  final String model;
  final int year;

  CarModel({
    this.url,
    this.localImage,
    required this.price,
    required this.marka,
    required this.model,
    required this.year,
  });
}
