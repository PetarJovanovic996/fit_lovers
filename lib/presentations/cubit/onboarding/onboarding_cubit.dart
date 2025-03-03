import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/models/validation/email.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';
import 'package:formz/formz.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(OnboardingState());

  final UserRepository _userRepository;

  void next() {
    if (state.step < 3) {
      emit(
        state.copyWith(
          step: state.step + 1,
        ),
      );
    }
  }

  void previous() {
    if (state.step > 0) {
      emit(state.copyWith(step: state.step - 1));
    }
  }

  void firstNameChanged(String value) {
    final newName = NotEmptyField.dirty(value);

    final isValidForm = Formz.validate([
      newName,
      state.lastName,
    ])
        ? FormzSubmissionStatus.success
        : FormzSubmissionStatus.failure;
    emit(
      state.copyWith(
        name: newName,
        status: isValidForm,
      ),
    );
  }

  void lastNameChanged(String value) {
    final newLastName = NotEmptyField.dirty(value);

    final isValidForm = Formz.validate([
      state.name,
      newLastName,
    ])
        ? FormzSubmissionStatus.success
        : FormzSubmissionStatus.failure;

    emit(
      state.copyWith(
        lastName: newLastName,
        status: isValidForm,
      ),
    );
  }

  void onDobChanged(DateTime? value) {
    if (value != null) {
      emit(state.copyWith(dob: value));
    }
  }

  void onWeightChanged(String value) {
    final newWeight = NotEmptyField2.dirty(value);

    final isValidForm = Formz.validate([
      newWeight,
      state.height,
    ])
        ? FormzSubmissionStatus.success
        : FormzSubmissionStatus.failure;

    emit(
      state.copyWith(
        weight: newWeight,
        step3status: isValidForm,
      ),
    );
  }

  void onHeightChanged(String value) {
    final newHeight = NotEmptyField2.dirty(value);

    final isValidForm = Formz.validate([
      state.weight,
      newHeight,
    ])
        ? FormzSubmissionStatus.success
        : FormzSubmissionStatus.failure;

    emit(
      state.copyWith(
        height: newHeight,
        step3status: isValidForm,
      ),
    );
  }

  Future<void> saveUserData() async {
    emit(state.copyWith(isLoading: true));

    try {
      await _userRepository.saveUserData(
        firstName: state.name.value,
        lastName: state.lastName.value,
        dateOfBirth: state.dob!,
        weight: state.weight.value,
        height: state.height.value,
      );
      // await _saveOnboardingCompletedStatus(true);

      emit(
        state.copyWith(
          isLoading: false,
          isCompleted: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
//
// //PEKIIIII
// //baci pogled za provjeri da li je klijent onb ili ne
// //prvo sam stavio da cuva status u sharedpref
// // provjera za logIn skrin button
// //skip button na onb skrin
// //testirano
//
//   Future<void> _saveOnboardingCompletedStatus(bool status) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('onboardingCompleted', status);
//   }
//
// // s pecom
// //ovo je pogresno
//   Future<void> checkOnboardingStatus() async {
//     emit(state.copyWith(isLoading: true));
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
//
//       if (onboardingCompleted) {
//         emit(state.copyWith(status: FormzSubmissionStatus.success));
//       } else {
//         emit(state.copyWith(status: FormzSubmissionStatus.failure));
//       }
//     } catch (e) {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           errorMessage: e.toString(),
//         ),
//       );
//     }
//   }

  // Future<void> skipOnboarding() async {
  //   emit(state.copyWith(isLoading: true));
  //   try {
  //     // await _saveOnboardingCompletedStatus(false);
  //     emit(state.copyWith(status: FormzSubmissionStatus.success));
  //   } catch (e) {
  //     emit(
  //       state.copyWith(
  //         isLoading: false,
  //         errorMessage: e.toString(),
  //       ),
  //     );
  //   }
  // }
}
