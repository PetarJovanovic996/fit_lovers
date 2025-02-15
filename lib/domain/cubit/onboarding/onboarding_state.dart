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

class OnboardingPageChanged extends OnboardingState {
  final int pageIndex;
  OnboardingPageChanged(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
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
