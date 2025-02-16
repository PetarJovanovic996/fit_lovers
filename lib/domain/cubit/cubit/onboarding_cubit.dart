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
  double? weight;
  double? height;

  void updateFirstName(String value) {
    firstName = value;
    emit(OnboardingDataChanged(
        firstName, lastName, dateOfBirth, weight, height));
  }

  void updateLastName(String value) {
    lastName = value;
    emit(OnboardingDataChanged(
        firstName, lastName, dateOfBirth, weight, height));
  }

  void updateDateOfBirth(DateTime value) {
    dateOfBirth = value;
    emit(OnboardingDataChanged(
        firstName, lastName, dateOfBirth, weight, height));
  }

  void updateWeight(double value) {
    weight = value;
    emit(OnboardingDataChanged(
        firstName, lastName, dateOfBirth, weight, height));
  }

  void updateHeight(double value) {
    height = value;
    emit(OnboardingDataChanged(
        firstName, lastName, dateOfBirth, weight, height));
  }

  void nextScreen() {
    emit(OnboardingNextScreen());
  }

  void prevScreen() {
    emit(OnboardingPrevScreen());
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
          weight == null ||
          height == null) {
        throw Exception("Some fields are missing.");
      }

      await userRepository.saveUserData(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth!,
        weight: weight!,
        height: height!,
      );
      await _saveOnboardingCompletedStatus(true);

      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
