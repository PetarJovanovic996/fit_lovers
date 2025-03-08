import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_status_state.dart';

class OnboardingStatusCubit extends Cubit<OnboardingStatusState> {
  OnboardingStatusCubit({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences,
        super(const OnboardingStatusState()) {
    _checkOnboardingStatus();
  }

  final SharedPreferences _sharedPreferences;

  void _checkOnboardingStatus() {
    final onboardingStatus =
        _sharedPreferences.getBool('__ONBOARDING_STATUS_KEY__');
    emit(
      state.copyWith(
        isOnboardingCompleted: onboardingStatus,
      ),
    );
  }

  Future<void> completeOnboarding() async {
    try {
      final onboardingStatus =
          await _sharedPreferences.setBool('__ONBOARDING_STATUS_KEY__', true);
      emit(
        state.copyWith(
          isOnboardingCompleted: onboardingStatus,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isOnboardingCompleted: false));
    }
  }
}
