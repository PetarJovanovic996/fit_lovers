import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepository userRepository;

  OnboardingCubit({required this.userRepository}) : super(OnboardingInitial());

  String firstName = "";
  String lastName = "";
  DateTime? dateOfBirth;
  String weight = "";
  String height = "";

  void updateFirstName(String value) {
    firstName = value;
    emit(state is OnboardingDataChanged
        ? (state as OnboardingDataChanged).copyWith(firstName: value)
        : OnboardingDataChanged(
            firstName, lastName, dateOfBirth, weight, height));
  }

  void updateLastName(String value) {
    lastName = value;
    emit(state is OnboardingDataChanged
        ? (state as OnboardingDataChanged).copyWith(lastName: value)
        : OnboardingDataChanged(
            firstName, lastName, dateOfBirth, weight, height));
  }

  bool isDateOfBirthValid() {
    return dateOfBirth != null;
  }

  void updateDateOfBirth(DateTime value) {
    dateOfBirth = value;
    emit(state is OnboardingDataChanged
        ? (state as OnboardingDataChanged).copyWith(dateOfBirth: value)
        : OnboardingDataChanged(
            firstName, lastName, dateOfBirth, weight, height));
  }

  void updateWeight(String value) {
    weight = value;
    emit(state is OnboardingDataChanged
        ? (state as OnboardingDataChanged).copyWith(weight: value)
        : OnboardingDataChanged(
            firstName, lastName, dateOfBirth, weight, height));
  }

  void updateHeight(String value) {
    height = value;
    emit(state is OnboardingDataChanged
        ? (state as OnboardingDataChanged).copyWith(height: value)
        : OnboardingDataChanged(
            firstName, lastName, dateOfBirth, weight, height));
  }

  Future<void> checkOnboardingStatus() async {
    emit(OnboardingLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

      if (onboardingCompleted) {
        emit(OnboardingCompleted());
      } else {
        emit(OnboardingRequired());
      }
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> completeOnboarding() async {
    emit(OnboardingLoading());
    try {
      await _saveOnboardingCompletedStatus(true);
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> skipOnboarding() async {
    emit(OnboardingLoading());
    try {
      await _saveOnboardingCompletedStatus(false);
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> _saveOnboardingCompletedStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingCompleted', status);
  }

  Future<void> saveUserData() async {
    emit(OnboardingLoading());

    try {
      if (firstName.isEmpty ||
          lastName.isEmpty ||
          dateOfBirth == null ||
          weight.isEmpty ||
          height.isEmpty) {
        throw Exception("Some fields are missing.");
      }

      await userRepository.saveUserData(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth!,
        weight: weight,
        height: height,
      );
      await _saveOnboardingCompletedStatus(true);

      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
