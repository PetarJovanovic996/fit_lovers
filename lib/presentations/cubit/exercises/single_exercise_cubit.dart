import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/models/exercise.dart';
import 'package:fit_lovers/data/services/exercises_service.dart';

part 'single_exercise_state.dart';

class SingleExerciseCubit extends Cubit<SingleExerciseState> {
  SingleExerciseCubit(this._exerciseService) : super(SingleExerciseInitial());

  final ExerciseService _exerciseService;

  Future<void> fetchSingleExercises(String name) async {
    emit(SingleExerciseLoading());
    try {
      final singleExercise = await _exerciseService.getSingleExercise(name);

      emit(SingleExerciseLoaded(singleExercise));
    } catch (e) {
      emit(SingleExerciseError(e.toString()));
    }
  }
}
