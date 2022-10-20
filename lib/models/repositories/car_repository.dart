import 'package:local_bloc_car/models/cars.model.dart';

class CarRepository {
  List<CarModel> getCars() {
    return _cars;
  }
}

final _cars = [
  CarModel(
      url: 'https://www.picknbuy24.com/photo/0120687405/01_l3.jpg',
      price: 63495,
      marka: 'BMW',
      model: 'M5',
      year: 2012),
  CarModel(
      url: 'https://www.picknbuy24.com/photo/0120620727/01_l3.jpg',
      price: 8200,
      marka: 'Honda',
      model: 'Fit',
      year: 2014),
  CarModel(
      url: 'https://www.picknbuy24.com/photo/0120739630/01_l3.jpg',
      price: 5600,
      marka: 'Toyota',
      model: 'Supra MK3',
      year: 2001),
  CarModel(
      url: 'https://www.picknbuy24.com/photo/0120709851/01_l3.jpg',
      price: 11000,
      marka: 'Subaru',
      model: 'IMPREZA WRX TYPE RA',
      year: 1986),
  CarModel(
      url: 'https://www.picknbuy24.com/photo/0120576663/01_l3.jpg',
      price: 18800,
      marka: 'Meresedes-Benz',
      model: 'S-Class',
      year: 2010),
  CarModel(
      url:
          'https://i.cars.kg/preview/r/mY7Q5FYpcx8fhtowbVmZ8w/1080x-/20220725/d1368cf32492d752b564a40867783b3e.jpg',
      price: 15200,
      marka: 'Chevrolet',
      model: 'Malibu Premium',
      year: 2017),
];
