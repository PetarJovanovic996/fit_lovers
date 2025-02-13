import 'package:fit_lovers/data/models/validation/email.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmailInputField extends StatelessWidget {
  const EmailInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return AppLocalizations.of(context)!.invalidMail;
        }
        return null;
      },
      onChanged: (value) {
        context.read<AuthCubit>().email = Email.dirty(value);
      },
    );
  }
}
