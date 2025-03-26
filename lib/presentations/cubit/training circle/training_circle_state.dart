part of 'training_circle_cubit.dart';

abstract class TrainingCircleState extends Equatable {
  const TrainingCircleState();
}

class TrainingCircleInitial extends TrainingCircleState {
  @override
  List<Object> get props => [];
}

class TrainingCircleLoading extends TrainingCircleState {
  @override
  List<Object> get props => [];
}

class TrainingCircleLoaded extends TrainingCircleState {
  const TrainingCircleLoaded(this.trainingCircle);
  final List<String> trainingCircle;
  @override
  List<Object?> get props => [trainingCircle];
}

class TrainingCircleError extends TrainingCircleState {
  const TrainingCircleError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
