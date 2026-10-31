
enum BmiCategory {
  underweight(
    'Underweight',
    'You Have a Lower Than Normal Body Weight. Try to Eat a Bit More.',
  ),
  normal('Normal', 'You Have a Normal Body Weight. Good Job.'),
  overweight(
    'Overweight',
    'You Have a Higher Than Normal Body Weight. Try to Exercise More.',
  ),
  obese(
    'Obese',
    'You Have a Much Higher Than Normal Body Weight. Consider Talking to a Doctor.',
  );

  const BmiCategory(this.label, this.description);

  final String label;
  final String description;
}

sealed class ResultState{
  const ResultState();

  
  List<Object?> get props => [];
}

final class ResultInitial extends ResultState {
  const ResultInitial();
}

final class ResultSuccess extends ResultState {
  const ResultSuccess({required this.bmi, required this.category});

  final double bmi;
  final BmiCategory category;

  @override
  List<Object?> get props => [bmi, category];
}

final class ResultFailure extends ResultState {
  const ResultFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
