part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  const OnboardingState({
    this.name = const NotEmptyField.pure(),
    this.lastName = const NotEmptyField.pure(),
    this.dob,
    this.weight = const NotEmptyField2.pure(),
    this.height = const NotEmptyField2.pure(),
    this.status = FormzSubmissionStatus.failure,
    this.step3status = FormzSubmissionStatus.failure,
    this.step = 0,
    this.errorMessage,
    this.isLoading = false,
    this.isCompleted = false,
  });

  final NotEmptyField name;
  final NotEmptyField lastName;
  final DateTime? dob;
  final NotEmptyField2 weight;
  final NotEmptyField2 height;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus step3status;
  final int step;
  final String? errorMessage;
  final bool isLoading;
  final bool isCompleted;

  @override
  List<Object?> get props => [
        name,
        lastName,
        dob,
        weight,
        height,
        status,
        step,
        step3status,
        errorMessage,
        isLoading,
        isCompleted,
      ];

  OnboardingState copyWith({
    NotEmptyField? name,
    NotEmptyField? lastName,
    DateTime? dob,
    NotEmptyField2? weight,
    NotEmptyField2? height,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? step3status,
    int? step,
    String? errorMessage,
    bool? isLoading,
    bool? isCompleted,
  }) {
    return OnboardingState(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dob: dob ?? this.dob,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      status: status ?? this.status,
      step: step ?? this.step,
      step3status: step3status ?? this.step3status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
