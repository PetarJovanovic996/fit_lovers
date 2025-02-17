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
    // TODO: Not a good approach to implement a [EmailInputField],
    // the way this is currently implemented is only good for [RegisterScreen]

    return TextFormField(
      // TODO: When creating multilingual applications, no text values can be hardcoded
      decoration: const InputDecoration(labelText: 'Email'),
      // TODO: What is the point of using [Email] if you are implementing the validator here?
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@')) {
          return AppLocalizations.of(context)!.invalidMail;
        }
        return null;
      },
      onChanged: (value) {
        // TODO: State handling!!!
        context.read<AuthCubit>().email = Email.dirty(value);
      },
    );
  }
}
