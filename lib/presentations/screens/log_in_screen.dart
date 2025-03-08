import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/presentations/cubit/authentication/login/login_cubit.dart';
import 'package:fit_lovers/presentations/cubit/favourites/favourites_cubit.dart';
import 'package:fit_lovers/presentations/cubit/onboarding/onboarding_status/onboarding_status_cubit.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:formz/formz.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // s pecom: When I restart the application, I need to login again. Missing save user session logic
    return Scaffold(
      appBar: CustomAppBar(
        title: (AppLocalizations.of(context)!.login),
        showSignOut: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (context) => LogInCubit(
            AuthenticationRepository(),
          ),
          child: const LogInForm(),
        ),
      ),
    );
  }
}

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogInCubit, LogInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(AppLocalizations.of(context)!.loggedIn),
              ),
            );

          final isOnboardingCompleted =
              context.read<OnboardingStatusCubit>().state.isOnboardingCompleted;

          if (isOnboardingCompleted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.homeScreen,
              (Route<dynamic> route) => false,
            );
            context.read<FavouritesCubit>().loadFavourites();
          } else {
            Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.onboardingScreen,
              (Route<dynamic> route) => false,
            );
          }
          context.read<FavouritesCubit>().loadFavourites();
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar
            ..showSnackBar(
              SnackBar(
                content: Text(
                    state.errorMessage ?? AppLocalizations.of(context)!.error),
              ),
            );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const _EmailInput(),
              const SizedBox(height: 16),
              const _PasswordInput(),
              const SizedBox(height: 16),
              if (state.status.isInProgress) const LoadingWidget(),
              const SizedBox(height: 16),
              _LogInButton(),
            ],
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email.value,
          onChanged: (email) => context.read<LogInCubit>().enteredEmail(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.emptyMail,
            errorText: state.email.displayError != null
                ? AppLocalizations.of(context)!.invalidMail
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password.value,
          obscureText: true,
          onChanged: (password) =>
              context.read<LogInCubit>().enteredPassword(password),
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.emptyPassword,
            errorText: state.password.displayError != null
                ? AppLocalizations.of(context)!.invalidPassword
                : null,
          ),
        );
      },
    );
  }
}

class _LogInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<LogInCubit>().logInWithCredentials();
      },
      child: Text(
        AppLocalizations.of(context)!.login,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
