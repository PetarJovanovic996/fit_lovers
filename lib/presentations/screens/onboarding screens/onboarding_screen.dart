import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/screens/onboarding%20screens/onboarding_screen2.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/my_skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          title: AppLocalizations.of(context)!.welcome,
          showSignOut: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.onboardingWelcome,
                    style: TextStyle(fontSize: 25),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.firstName,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 2) {
                        return AppLocalizations.of(context)!.invalidInput;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<OnboardingCubit>().updateFirstName(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.lastName),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 2) {
                        return AppLocalizations.of(context)!.invalidInput;
                      }
                      return null;
                    },
                    onChanged: (value) {
                      context.read<OnboardingCubit>().updateLastName(value);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        context.read<OnboardingCubit>().nextScreen();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OnboardingScreen2()),
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  MySkipButton(),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
