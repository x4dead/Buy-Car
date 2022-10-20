import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_bloc_car/models/cars.model.dart';

import 'package:stream_transform/stream_transform.dart';

import '../models/repositories/car_repository.dart';

EventTransformer<E> _restartableDebounce<E>() {
  return (events, mapper) =>
      events.debounce(const Duration(milliseconds: 400)).switchMap(mapper);
}

class CarBloc extends Bloc<CarEvents, CarStates> {
  CarBloc({required this.carRepo}) : super(CarInitialState([])) {
    on<GetCars>((event, emit) async {
      emit(CarLoadingState(state.cars));
      final List<CarModel> cars = carRepo.getCars();
      allCars = cars;
      await Future.delayed(const Duration(seconds: 1));
      emit(CarSuccesState(cars));
    });
    //
    on<DeleteCars>((event, emit) {});
    //
    on<FilterCars>((event, emit) async {
      emit(CarLoadingState(state.cars));

      switch (event.filter) {
        case Filter.byNameUp:
          allCars.sort((a, b) => a.marka.compareTo(b.marka));

          break;
        case Filter.byNameDown:
          allCars.sort((a, b) => b.marka.compareTo(a.marka));

          break;
        case Filter.byPriceUp:
          allCars.sort((a, b) => a.price.compareTo(b.price));

          break;
        case Filter.byPriceDown:
          allCars.sort((a, b) => b.price.compareTo(a.price));

          break;
        case Filter.byYearUp:
          allCars.sort((a, b) => a.year.compareTo(b.year));

          break;
        case Filter.byYearDown:
          allCars.sort((a, b) => b.year.compareTo(a.year));

          break;
      }

      emit(CarSuccesState(state.cars));
    });
    //
    on<SearchCars>((event, emit) async {
      emit(CarLoadingState(state.cars));
      await Future.delayed(const Duration(milliseconds: 300));
      final newCars = allCars.where((e) {
        final fullName = '${e.marka} ${e.model}';
        return fullName.toLowerCase().contains(event.text.toLowerCase());
      }).toList();

      emit(CarSuccesState(newCars));
      if (newCars.isEmpty) {
        emit(CarErrorState(newCars));
      } else {}
    }, transformer: _restartableDebounce());
    //
    on<AddCars>((event, emit) async {
      emit(CarLoadingState(state.cars));
      await Future.delayed(const Duration(seconds: 3));
      allCars.add(event.car);
      emit(CarSuccesState(allCars));
    });
  }
  final CarRepository carRepo;
  List<CarModel> allCars = [];
}

//Event'ы события
abstract class CarEvents {}

class GetCars extends CarEvents {}

class FilterCars extends CarEvents {
  final Filter filter;

  FilterCars(this.filter);
}

class AddCars extends CarEvents {
  final CarModel car;

  AddCars({required this.car});
}

class DeleteCars extends CarEvents {}

class SearchCars extends CarEvents {
  final String text;

  SearchCars(this.text);
}

enum Filter {
  byNameUp,
  byNameDown,
  byPriceUp,
  byPriceDown,
  byYearUp,
  byYearDown,
}

//State'ы состояния
abstract class CarStates {
  final List<CarModel> cars;

  CarStates(this.cars);
}

class CarLoadingState extends CarStates {
  @override
  // ignore: overridden_fields
  final List<CarModel> cars;

  CarLoadingState(this.cars) : super(cars);
}

class CarErrorState extends CarStates {
  CarErrorState(this.cars) : super(cars);
  @override
  // ignore: overridden_fields
  final List<CarModel> cars;
}

class CarSuccesState extends CarStates {
  @override
  // ignore: overridden_fields
  final List<CarModel> cars;

  CarSuccesState(this.cars) : super(cars);
}

class CarInitialState extends CarStates {
  @override
  // ignore: overridden_fields
  final List<CarModel> cars;

  CarInitialState(this.cars) : super(cars);
}
