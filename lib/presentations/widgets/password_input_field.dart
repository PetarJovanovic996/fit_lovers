import 'package:fit_lovers/data/models/validation/password.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordInputField extends StatelessWidget {
  const PasswordInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Check comments left on EmailInputField, all apply here.
    return TextFormField(
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
    );
  }
}
