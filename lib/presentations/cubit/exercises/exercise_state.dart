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
  const ExerciseLoaded({
    required this.exercises,
    required this.allExercises,
  });

  // Holds [EITHER] list of all exercises or list of filtered exercises,
  // This List is used to display items on [HomeTabContent]
  final List<Exercise> exercises;
  // Holds the list of all exercises at all times
  // We use this list, to ensure we can extract favourites properly.
  final List<Exercise> allExercises;

  @override
  List<Object?> get props => [
        exercises,
        allExercises,
      ];
}

class ExerciseError extends ExerciseState {
  const ExerciseError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
