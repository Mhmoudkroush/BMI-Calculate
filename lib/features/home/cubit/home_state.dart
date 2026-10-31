
enum Gender { male, female }

sealed class HomeState {
  const HomeState({
    required this.height,
    required this.weight,
    required this.age,
    this.gender,
  });

  final double height;
  final int weight;
  final int age;
  final Gender? gender;

  HomeUpdated copyWith({
    Gender? gender,
    double? height,
    int? weight,
    int? age,
  }) {
    return HomeUpdated(
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      age: age ?? this.age,
    );
  }

  List<Object?> get props => [height, weight, age, gender];
}
class HomeInitial extends HomeState {
  const HomeInitial() : super(height: 100, weight: 80, age: 22);
}

final class HomeUpdated extends HomeState {
  const HomeUpdated({
    required super.height,
    required super.weight,
    required super.age,
    super.gender,
  });
}
