import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/presentations/cubit/authentication/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
            SnackBar(content: Text(state.errorMessage ?? 'Error')),
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
    return TextField(
      onChanged: (email) => context.read<RegisterCubit>().enteredEmail(email),
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        errorText:
            context.read<RegisterCubit>().state.email.displayError != null
                ? 'invalid email'
                : null,
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _ConsentButton extends StatelessWidget {
  const _ConsentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _RegisterButton extends StatelessWidget {
  const _RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
