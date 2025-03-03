part of 'exercise_cubit.dart';

abstract class ExerciseState extends Equatable {
  const ExerciseState();
}

final class ExerciseInitial extends ExerciseState {
  @override
  List<Object> get props => [];
}

class ExerciseLoading extends ExerciseState {
  @override
  List<Object?> get props => [];
}

class ExerciseLoaded extends ExerciseState {
  const ExerciseLoaded(this.exercises);
  final List<Exercise> exercises;
  @override
  List<Object?> get props => [exercises];
}

class ExerciseError extends ExerciseState {
  const ExerciseError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
