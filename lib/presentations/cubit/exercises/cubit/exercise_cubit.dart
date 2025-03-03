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
}
