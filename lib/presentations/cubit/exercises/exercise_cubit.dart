import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/models/exercise.dart';
import 'package:fit_lovers/data/services/exercises_service.dart';

part 'exercise_state.dart';

class ExerciseCubit extends Cubit<ExerciseState> {
  ExerciseCubit(this._exerciseService) : super(ExerciseInitial()) {
    fetchAllExercises();
  }
  final ExerciseService _exerciseService;

  Future<void> fetchAllExercises() async {
    emit(ExerciseLoading());
    try {
      final allExercises = await _exerciseService.fetchExercises();

      // When fetching all exercises, both [exercises] and [allExercises] are the same
      emit(ExerciseLoaded(
        allExercises: allExercises,
        exercises: allExercises,
      ));
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }

  Future<void> fetchFilteredExercises({
    String? type,
    String? name,
  }) async {
    // Before emitting Loading state, extract [allExercises] from the current state
    final allExercises = (state as ExerciseLoaded).allExercises;

    emit(ExerciseLoading());
    try {
      final filteredExercises = await _exerciseService.fetchExercises(
        type: type,
        name: name,
      );

      emit(
        ExerciseLoaded(
          exercises: filteredExercises,
          // Copy allExercises from previous state, to the new one
          allExercises: allExercises,
        ),
      );
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }
}
