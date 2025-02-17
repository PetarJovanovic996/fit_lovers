import 'package:fit_lovers/data/models/validation/confirm_password.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_state.dart';
import 'package:fit_lovers/presentations/widgets/consent_button.dart';
import 'package:fit_lovers/presentations/widgets/email_input_field.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fit_lovers/core/routes.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: Update colors / design, it's not user friendly at all, I can barely read what I typed in.
    // Grey background color is not optimal in any way.
    return Scaffold(
      appBar: MyAppBar(title: AppLocalizations.of(context)!.register),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(AppLocalizations.of(context)!.login)),
              );
              Navigator.of(context).pushReplacementNamed(Routes.logInScreen);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          // TODO: Form widget and _formKey are not needed when state is handled as it should be through Cubits
          //  Refactor
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                EmailInputField(),
                SizedBox(height: 16),
                PasswordInputField(),
                const SizedBox(height: 16),

                // Confirm Password Field
                _ConfirmPasswordField(),
                const SizedBox(height: 16),

                // Checkbox
                ConsentButton(),
                const SizedBox(height: 16),

                // Register Button
                // TODO: Form validation is not supposed to be done like this.
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthCubit>().register(
                            context.read<AuthCubit>().email.value,
                            context.read<AuthCubit>().password.value,
                            context.read<AuthCubit>().confirmPassword.value,
                            context.read<AuthCubit>().consent.value,
                          );
                    }
                  },
                  child: Text(
                    AppLocalizations.of(context)!.register,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmPasswordField extends StatelessWidget {
  const _ConfirmPasswordField();

  @override
  Widget build(BuildContext context) {
    // TODO: Check comments left on EmailInputField, all apply here.
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: AppLocalizations.of(context)!.confirmPassword),
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            value != context.read<AuthCubit>().password.value) {
          return AppLocalizations.of(context)!.passwordDontMatch;
        }
        return null;
      },
      onChanged: (value) {
        context.read<AuthCubit>().confirmPassword = ConfirmPassword.dirty(
          value: value,
          password: context.read<AuthCubit>().password.value,
        );
      },
    );
  }
}
