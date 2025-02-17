import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/screens/onboarding%20screens/onboarding_screen3.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:fit_lovers/presentations/widgets/my_skip_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen2 extends StatelessWidget {
  const OnboardingScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.onboarding,
        showSignOut: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );

                if (pickedDate != null && context.mounted) {
                  context.read<OnboardingCubit>().updateDateOfBirth(pickedDate);
                }
              },
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.white,
                child: BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    final dateOfBirth =
                        context.read<OnboardingCubit>().dateOfBirth;
                    final isDateValid =
                        context.read<OnboardingCubit>().isDateOfBirthValid();

                    return Text(
                      isDateValid
                          ? '${dateOfBirth?.toLocal()}'.split(' ')[0]
                          : AppLocalizations.of(context)!.selectDateOfBirth,
                      style: TextStyle(fontSize: 16),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
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
                    if (!context.read<OnboardingCubit>().isDateOfBirthValid()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context)!
                                .selectDateOfBirthError,
                            style: TextStyle(fontSize: 20),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 95, 88, 88),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => OnboardingScreen3()),
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
            ),
          ],
        ),
      ),
    );
  }
}
