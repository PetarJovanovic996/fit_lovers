import 'package:fit_lovers/presentations/cubit/onboarding/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/cubit/onboarding/onboarding_status/onboarding_status_cubit.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.editProfile),
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        listener: (context, state) {
          if (state.isCompleted) {
            context.read<OnboardingStatusCubit>().completeOnboarding();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.editProfile,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  initialValue: state.name.value,
                  onChanged: (value) =>
                      context.read<OnboardingCubit>().firstNameChanged(value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: state.lastName.value,
                  onChanged: (value) =>
                      context.read<OnboardingCubit>().lastNameChanged(value),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
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
                    state.dob.toString().split(' ')[0],
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                TextFormField(
                  initialValue: state.weight.value,
                  onChanged: (value) =>
                      context.read<OnboardingCubit>().onWeightChanged(value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: state.height.value,
                  onChanged: (value) =>
                      context.read<OnboardingCubit>().onHeightChanged(value),
                ),
                const SizedBox(height: 36),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                  ),
                  onPressed: () {
                    context.read<OnboardingCubit>().saveUserData();

                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.finish,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
