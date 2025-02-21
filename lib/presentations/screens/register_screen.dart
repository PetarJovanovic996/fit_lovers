import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/presentations/cubit/authentication/register/register_cubit.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: (AppLocalizations.of(context)!.register),
        showSignOut: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (context) => RegisterCubit(
            AuthenticationRepository(),
          ),
          child: RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppLocalizations.of(context)!.login)),
          );

          Navigator.of(context).pushReplacementNamed(Routes.logInScreen);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.errorMessage ?? AppLocalizations.of(context)!.error),
            ),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _EmailInput(),
          const SizedBox(height: 8),
          _PasswordInput(),
          const SizedBox(height: 8),
          _ConfirmPasswordInput(),
          const SizedBox(height: 8),
          _ConsentButton(),
          const SizedBox(height: 8),
          _RegisterButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (prev, curr) => prev.email != curr.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<RegisterCubit>().enteredEmail(email),
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
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (prev, curr) => prev.password != curr.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (password) =>
              context.read<RegisterCubit>().enteredPassword(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (prev, curr) =>
          (prev.confirmedPassword != curr.confirmedPassword) ||
          (prev.password != curr.password),
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (password) =>
              context.read<RegisterCubit>().confirmedPassword(password),
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.confirmPassword,
            errorText: state.confirmedPassword.displayError != null
                ? AppLocalizations.of(context)!.passwordDontMatch
                : null,
          ),
        );
      },
    );
  }
}

class _ConsentButton extends StatelessWidget {
  const _ConsentButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return CheckboxListTile(
          title: Text(AppLocalizations.of(context)!.termsAndConditions),
          value: state.consent.value,
          onChanged: (clickedConsent) =>
              context.read<RegisterCubit>().consentClicked(clickedConsent!),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.read<RegisterCubit>().registerFormSubmitted(),
      child: Text(
        AppLocalizations.of(context)!.register,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
