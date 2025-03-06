part of 'single_exercise_cubit.dart';

abstract class SingleExerciseState extends Equatable {
  const SingleExerciseState();
}

final class SingleExerciseInitial extends SingleExerciseState {
  @override
  List<Object> get props => [];
}

class SingleExerciseLoading extends SingleExerciseState {
  @override
  List<Object?> get props => [];
}

class SingleExerciseLoaded extends SingleExerciseState {
  const SingleExerciseLoaded(this.exercise);
  final Exercise exercise;
  @override
  List<Object?> get props => [exercise];
}

class SingleExerciseError extends SingleExerciseState {
  const SingleExerciseError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
