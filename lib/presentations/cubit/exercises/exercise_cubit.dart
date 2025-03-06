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

      emit(ExerciseLoaded(allExercises));
    } catch (e) {
      emit(ExerciseError(e.toString()));
    }
  }

  void searchExercises(String query) async {
    final allExercises = await _exerciseService.fetchExercises();
    emit(ExerciseLoading());
    try {
      final filteredExercises = allExercises
          .where((exercise) =>
              exercise.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ExerciseLoaded(filteredExercises));
    } catch (e) {
      {
        emit(ExerciseError(e.toString()));
      }
    }
  }
}
