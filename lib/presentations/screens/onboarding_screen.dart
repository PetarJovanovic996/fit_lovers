import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/presentations/cubit/onboarding/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingFrame();
  }
}

class OnboardingFrame extends StatelessWidget {
  const OnboardingFrame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: (AppLocalizations.of(context)!.onboarding)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  if (state.step == 0) {
                    return Expanded(child: OnboardingStep1());
                  } else if (state.step == 1) {
                    return Expanded(child: OnboardingStep2());
                  } else if (state.step == 2) {
                    return Expanded(child: OnboardingStep3());
                  }
                  return Expanded(child: OnboardingSummary());
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OnboardingBackButton(),
                  OnboardingSkipButton(),
                  OnboardingNextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingBackButton extends StatelessWidget {
  const OnboardingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        if (state.step == 0) {
          return SizedBox.shrink();
        }
        return IconButton(
          onPressed: () => context.read<OnboardingCubit>().previous(),
          icon: Icon(
            Icons.arrow_back,
            size: 32,
          ),
        );
      },
    );
  }
}

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context.read<OnboardingCubit>().skipOnboarding();
            Navigator.of(context).pushNamed(Routes.homeScreen);
          },
          child: Text(
            AppLocalizations.of(context)!.skip,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}

class OnboardingNextButton extends StatelessWidget {
  const OnboardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            if (state.step == 1) {
              if (state.dob == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        AppLocalizations.of(context)!.selectDateOfBirthError)));
                return;
              }
            }
            if (state.step < 2) {
              if (state.status == FormzSubmissionStatus.success) {
                context.read<OnboardingCubit>().next();
              }
            }
// PEKIIIIII
// Mozes bacit pogled, morao sam da stavim <2 , jer mi nije obuhvatalo
//step sa odabirom datuma, ako samo stavim na prvi step,odnosno na nulti
//uglavnom radi
            if (state.step == 2) {
              if (state.step3status == FormzSubmissionStatus.success) {
                context.read<OnboardingCubit>().next();
              }
            }
          },
          //done: SA PECOM
          //peki provjeri ovo
          //prolazi 3 korak tez i visinu, bez ikakvog unosa
          icon: Icon(
            Icons.arrow_forward,
            size: 32,
          ),
        );
      },
    );
  }
}

class OnboardingStep1 extends StatelessWidget {
  const OnboardingStep1({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.firstAndLastName),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.name.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: (AppLocalizations.of(context)!.name),
                  errorText: state.name.displayError != null
                      ? AppLocalizations.of(context)!.invalidEntry
                      : null,
                ),
                onChanged: (value) =>
                    context.read<OnboardingCubit>().firstNameChanged(value),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.lastName.value,
                decoration: InputDecoration(
                  hintText: (AppLocalizations.of(context)!.lastName),
                  border: OutlineInputBorder(),
                  errorText: state.lastName.displayError != null
                      ? AppLocalizations.of(context)!.invalidEntry
                      : null,
                ),
                onChanged: (value) =>
                    context.read<OnboardingCubit>().lastNameChanged(value),
              )
            ],
          ),
        );
      },
    );
  }
}

class OnboardingStep2 extends StatelessWidget {
  const OnboardingStep2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.dateOfBirth),
            const SizedBox(height: 12),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100, 75),
                ),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1950),
                    lastDate: DateTime.now(),
                  );

                  if (context.mounted) {
                    context.read<OnboardingCubit>().onDobChanged(pickedDate);
                  }
                },
                child: Text(
                  state.dob?.toString().split(' ')[0] ??
                      AppLocalizations.of(context)!.selectDateOfBirthError,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class OnboardingStep3 extends StatelessWidget {
  const OnboardingStep3({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppLocalizations.of(context)!.weightAndHeight),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.weight.value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.weight,
                  border: OutlineInputBorder(),
                  errorText: state.weight.displayError != null
                      ? AppLocalizations.of(context)!.invalidEntry
                      : null,
                ),
                onChanged: (value) =>
                    context.read<OnboardingCubit>().onWeightChanged(value),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.height.value,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.height,
                  border: OutlineInputBorder(),
                  errorText: state.height.displayError != null
                      ? AppLocalizations.of(context)!.invalidEntry
                      : null,
                ),
                onChanged: (value) =>
                    context.read<OnboardingCubit>().onHeightChanged(value),
              )
            ],
          ),
        );
      },
    );
  }
}

class OnboardingSummary extends StatelessWidget {
  const OnboardingSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.checkData,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                initialValue: state.name.value,
                enabled: false,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.lastName.value,
                enabled: false,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.dob.toString().split(' ')[0],
                enabled: false,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.weight.value,
                enabled: false,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: state.height.value,
                enabled: false,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  context.read<OnboardingCubit>().saveUserData();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          AppLocalizations.of(context)!.succesfullOnboarding)));
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.homeScreen,
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  AppLocalizations.of(context)!.finish,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
