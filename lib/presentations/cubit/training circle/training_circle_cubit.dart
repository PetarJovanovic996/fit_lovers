import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';

part 'training_circle_state.dart';

class TrainingCircleCubit extends Cubit<TrainingCircleState> {
  final UserRepository _userRepository;

  TrainingCircleCubit(this._userRepository) : super(TrainingCircleInitial());
  Future<void> loadTrainingCircle() async {
    emit(TrainingCircleLoading());
    try {
      final trainingCircle = await _userRepository.getTrainingCircle();
      emit(TrainingCircleLoaded(trainingCircle));
    } catch (e) {
      emit(TrainingCircleError(e.toString()));
    }
  }

  Future<void> addTrainingCircle(String exerciseName) async {
    try {
      await _userRepository.addTrainingCircle(exerciseName);
      loadTrainingCircle();
    } catch (e) {
      emit(TrainingCircleError(e.toString()));
    }
  }

  Future<void> removeTrainingCircle() async {
    try {
      await _userRepository.removeTrainingCircle();
      final trainingCircle = await _userRepository.getTrainingCircle();
      emit(TrainingCircleLoaded(trainingCircle));
    } catch (e) {
      emit(TrainingCircleError(e.toString()));
    }
  }
}
