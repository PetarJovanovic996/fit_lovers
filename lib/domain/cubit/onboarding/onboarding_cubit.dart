import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepository userRepository;

  OnboardingCubit({required this.userRepository}) : super(OnboardingInitial());

  int currentPage = 0;
  String firstName = "";
  String lastName = "";
  DateTime? dateOfBirth;
  double? weight;
  double? height;

  void nextPage() {
    if (currentPage < 3) {
      currentPage++;
      emit(OnboardingPageChanged(currentPage));
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      emit(OnboardingPageChanged(currentPage));
    }
  }

  void updateUserData(
      {String? fName, String? lName, DateTime? dob, double? w, double? h}) {
    firstName = fName ?? firstName;
    lastName = lName ?? lastName;
    dateOfBirth = dob ?? dateOfBirth;
    weight = w ?? weight;
    height = h ?? height;
  }

  Future<void> saveUserData() async {
    emit(OnboardingLoading());
    try {
      await userRepository.saveUserData(
        firstName: firstName,
        lastName: lastName,
        dateOfBirth: dateOfBirth!,
        weight: weight!,
        height: height!,
      );
      emit(OnboardingCompleted());
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
