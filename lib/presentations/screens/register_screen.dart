import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/presentations/cubit/authentication/register/register_cubit.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
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
          child: const RegisterForm(),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(AppLocalizations.of(context)!.succesfullRegistration)),
          );

          Navigator.of(context).pushReplacementNamed(Routes.logInScreen);
        }
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  state.errorMessage ?? AppLocalizations.of(context)!.error),
            ),
          );
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _EmailInput(),
            const SizedBox(height: 8),
            const _PasswordInput(),
            const SizedBox(height: 8),
            const _ConfirmPasswordInput(),
            const SizedBox(height: 8),
            const _ConsentButton(),
            const SizedBox(height: 8),
            if (state.status.isInProgress) const LoadingWidget(),
            const SizedBox(height: 8),
            _RegisterButton(),
          ],
        );
      },
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
        return TextFormField(
          initialValue: state.email.value,
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
        return TextFormField(
          obscureText: true,
          initialValue: state.password.value,
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
        return TextFormField(
          initialValue: state.confirmedPassword.value,
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CheckboxListTile(
              title: Text(AppLocalizations.of(context)!.termsAndConditions),
              value: state.consent.value,
              onChanged: (clickedConsent) =>
                  context.read<RegisterCubit>().consentClicked(clickedConsent!),
            ),
            if (!state.consent.value && state.status.isFailure)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  AppLocalizations.of(context)!.invalidTemrsAndConditions,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        // if (!state.isValid) {
        //   return ElevatedButton(
        //     onPressed: null,
        //     child: Text(
        //       AppLocalizations.of(context)!.register,
        //       style: TextStyle(color: Colors.black),
        //     ),
        //   );
        // }

        return ElevatedButton(
          onPressed: () =>
              context.read<RegisterCubit>().registerFormSubmitted(),
          child: Text(
            AppLocalizations.of(context)!.register,
            style: const TextStyle(color: Colors.black),
          ),
        );
      },
    );
  }
}
