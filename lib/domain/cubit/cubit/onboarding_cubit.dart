import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final UserRepository userRepository;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      if (firstName.isEmpty ||
          lastName.isEmpty ||
          dateOfBirth == null ||
          weight == null ||
          height == null) {
        emit(OnboardingError(toString()));
        return;
      }
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

  Future<void> checkOnboardingStatus() async {
    emit(OnboardingLoading());
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        emit(OnboardingRequired()); // Ako nije ulogovan, treba mu onboarding
        return;
      }

      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists && (userDoc['onboardingCompleted'] ?? false)) {
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
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'onboardingCompleted': true,
        });
        emit(OnboardingCompleted());
      }
    } catch (e) {
      emit(OnboardingError(e.toString()));
    }
  }
}
