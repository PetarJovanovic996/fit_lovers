part of 'onboarding_status_cubit.dart';

class OnboardingStatusState extends Equatable {
  const OnboardingStatusState({
    this.isOnboardingCompleted = false,
  });

  final bool isOnboardingCompleted;

  @override
  List<Object?> get props => [isOnboardingCompleted];

  OnboardingStatusState copyWith({bool? isOnboardingCompleted}) =>
      OnboardingStatusState(
        isOnboardingCompleted:
            isOnboardingCompleted ?? this.isOnboardingCompleted,
      );
}
