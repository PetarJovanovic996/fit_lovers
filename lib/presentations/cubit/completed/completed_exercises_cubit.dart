import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';

part 'completed_exercises_state.dart';

class CompletedExercisesCubit extends Cubit<CompletedExercisesState> {
  final UserRepository _userRepository;

  CompletedExercisesCubit(this._userRepository)
      : super(CompletedExercisesInitial());

  Future<void> loadCompleted() async {
    emit(CompletedExercisesLoading());
    try {
      final completed = await _userRepository.getCompleted();
      emit(CompletedExercisesLoaded(completed));
    } catch (e) {
      emit(CompletedExercisesError(e.toString()));
    }
  }

  Future<void> addCompleted(String exerciseName) async {
    try {
      await _userRepository.addCompleted(exerciseName);
      final completed = await _userRepository.getCompleted();
      emit(CompletedExercisesLoaded(completed));
    } catch (e) {
      emit(CompletedExercisesError(e.toString()));
    }
  }

  Future<void> removeCompleted(String exerciseName) async {
    try {
      await _userRepository.removeCompleted(exerciseName);
      final completed = await _userRepository.getCompleted();
      emit(CompletedExercisesLoaded(completed));
    } catch (e) {
      emit(CompletedExercisesError(e.toString()));
    }
  }
}
