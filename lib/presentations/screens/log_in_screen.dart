import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/models/validation/email.dart';
import 'package:fit_lovers/data/models/validation/password.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_state.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
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
              Navigator.of(context)
                  .pushReplacementNamed(Routes.onboardingScreen);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Email Field
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains('@')) {
                      return AppLocalizations.of(context)!.invalidMail;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<AuthCubit>().email = Email.dirty(value);
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return AppLocalizations.of(context)!.invalidPassword;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    context.read<AuthCubit>().password = Password.dirty(value);
                  },
                ),
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
                  child: Text(AppLocalizations.of(context)!.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
