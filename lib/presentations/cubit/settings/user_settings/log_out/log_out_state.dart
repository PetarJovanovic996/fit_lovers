part of 'log_out_cubit.dart';

abstract class LogOutState extends Equatable {}

class LogOutInitial extends LogOutState {
  @override
  List<Object?> get props => [];
}

class LogOutLoading extends LogOutState {
  @override
  List<Object?> get props => [];
}

class LogOutCompleted extends LogOutState {
  @override
  List<Object?> get props => [];
}

class LogOutErrorState extends LogOutState {
  final String errorMessage;
  LogOutErrorState(this.errorMessage);
  @override
  List<Object> get props => [errorMessage];
}
