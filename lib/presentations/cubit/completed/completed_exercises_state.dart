part of 'completed_exercises_cubit.dart';

abstract class CompletedExercisesState extends Equatable {
  const CompletedExercisesState();
}

class CompletedExercisesInitial extends CompletedExercisesState {
  @override
  List<Object> get props => [];
}

class CompletedExercisesLoading extends CompletedExercisesState {
  @override
  List<Object> get props => [];
}

class CompletedExercisesLoaded extends CompletedExercisesState {
  const CompletedExercisesLoaded(this.completed);
  final List<String> completed;
  @override
  List<Object?> get props => [completed];
}

class CompletedExercisesError extends CompletedExercisesState {
  const CompletedExercisesError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
