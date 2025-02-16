import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/screens/onboarding%20screens/onboarding_screen4.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen3 extends StatelessWidget {
  OnboardingScreen3({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.onboarding,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight'),
                onChanged: (value) {
                  context.read<OnboardingCubit>().updateWeight(value);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Height'),
                onChanged: (value) {
                  context.read<OnboardingCubit>().updateHeight(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 2) {
                    return AppLocalizations.of(context)!.invalidInput;
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => OnboardingScreen4()),
                        );
                      }
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
