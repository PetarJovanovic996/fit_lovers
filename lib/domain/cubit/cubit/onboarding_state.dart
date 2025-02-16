part of 'onboarding_cubit.dart';

abstract class OnboardingState extends Equatable {}

class OnboardingInitial extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingLoading extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingDataChanged extends OnboardingState {
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String weight;
  final String height;

  OnboardingDataChanged(this.firstName, this.lastName, this.dateOfBirth,
      this.weight, this.height);

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        dateOfBirth,
        weight,
        height,
      ];
}

class OnboardingNextScreen extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingPrevScreen extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingRequired extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingCompleted extends OnboardingState {
  @override
  List<Object> get props => [];
}

class OnboardingError extends OnboardingState {
  final String errorMessage;

  OnboardingError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
