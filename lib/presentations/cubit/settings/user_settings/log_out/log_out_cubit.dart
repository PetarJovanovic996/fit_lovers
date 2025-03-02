import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this._authenticationRepository) : super(LogOutInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logOut() async {
    emit(LogOutLoading());
    try {
      await _authenticationRepository.logOut();
      emit(LogOutCompleted());
    } catch (e) {
      emit(LogOutErrorState(e.toString()));
    }
  }
}
