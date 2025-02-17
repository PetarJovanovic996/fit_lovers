import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/screens/onboarding%20screens/onboarding_screen4.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/my_skip_button.dart';
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
        showSignOut: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  String weight =
                      (state is OnboardingDataChanged) ? state.weight : '';
                  String height =
                      (state is OnboardingDataChanged) ? state.height : '';

                  return Column(
                    children: [
                      TextFormField(
                        initialValue: weight,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.weight,
                        ),
                        onChanged: (value) {
                          context.read<OnboardingCubit>().updateWeight(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.invalidInput;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      TextFormField(
                        initialValue: height,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.height,
                        ),
                        onChanged: (value) {
                          context.read<OnboardingCubit>().updateHeight(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.invalidInput;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  );
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.back,
                      style: TextStyle(color: Colors.black),
                    ),
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
                    child: Text(
                      AppLocalizations.of(context)!.next,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
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
    );
  }
}
