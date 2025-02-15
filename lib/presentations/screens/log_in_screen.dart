import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_state.dart';
import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/widgets/email_input_field.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: AppLocalizations.of(context)!.login),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.loggedIn)),
              );
              context.read<OnboardingCubit>().checkOnboardingStatus();
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: BlocListener<OnboardingCubit, OnboardingState>(
            listener: (context, state) {
              if (state is OnboardingRequired) {
                Navigator.of(context)
                    .pushReplacementNamed(Routes.onboardingScreen);
              } else if (state is OnboardingCompleted) {
                Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  EmailInputField(),
                  const SizedBox(height: 16),
                  PasswordInputField(),
                  const SizedBox(height: 16),

                  // Login Button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().login(
                              context.read<AuthCubit>().email.value,
                              context.read<AuthCubit>().password.value,
                            );
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.login,
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
