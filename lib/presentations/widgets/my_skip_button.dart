import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MySkipButton extends StatelessWidget {
  const MySkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<OnboardingCubit>().skipOnboarding();
        Navigator.of(context).pushNamed(Routes.homeScreen);
      },
      child: Text(
        AppLocalizations.of(context)!.skip,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
