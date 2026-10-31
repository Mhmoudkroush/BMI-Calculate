import 'package:bmi_calculate/features/result/cubit/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultCubit extends Cubit<ResultState> {
  ResultCubit() : super(const ResultInitial());

  void calculate({required double height, required double weight}) {
    if (height <= 0 || weight <= 0) {
      emit(const ResultFailure('Height and weight must be greater than zero.'));
      return;
    }
    final meters = height / 100;
    final bmi = weight / (meters * meters);
    emit(ResultSuccess(bmi: bmi, category: _categorize(bmi)));
  }

  BmiCategory _categorize(double bmi) {
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25) return BmiCategory.normal;
    if (bmi < 30) return BmiCategory.overweight;
    return BmiCategory.obese;
  }
}