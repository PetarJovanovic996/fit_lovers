import 'package:fit_lovers/domain/cubit/authentication/auth_cubit.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConsentButton extends StatelessWidget {
  const ConsentButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final consent = context.read<AuthCubit>().consent;
        return CheckboxListTile(
          value: consent.value,
          onChanged: (value) {
            context.read<AuthCubit>().updateConsent(value!);
          },
          title: Text(AppLocalizations.of(context)!.termsAndConditions),
        );
      },
    );
  }
}
