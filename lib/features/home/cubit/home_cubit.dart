import 'package:bmi_calculate/features/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static const double minHeight = 100;
  static const double maxHeight = 200;
  static const int minWeight = 10;
  static const int maxWeight = 300;
  static const int minAge = 1;
  static const int maxAge = 120;

  void selectGender(Gender gender) => emit(state.copyWith(gender: gender));

  void setHeight(double value) =>
      emit(state.copyWith(height: value.clamp(minHeight, maxHeight).toDouble()));

  void incrementWeight() => _setWeight(state.weight + 1);
  void decrementWeight() => _setWeight(state.weight - 1);

  void incrementAge() => _setAge(state.age + 1);
  void decrementAge() => _setAge(state.age - 1);

  void _setWeight(int value) =>
      emit(state.copyWith(weight: value.clamp(minWeight, maxWeight).toInt()));

  void _setAge(int value) =>
      emit(state.copyWith(age: value.clamp(minAge, maxAge).toInt()));
}
  