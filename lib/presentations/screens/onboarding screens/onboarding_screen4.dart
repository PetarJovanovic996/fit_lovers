import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/widgets/loading_widget.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnboardingScreen4 extends StatelessWidget {
  const OnboardingScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.onboarding,
        showSignOut: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingLoading) {
              return LoadingWidget();
            }

            if (state is OnboardingDataChanged) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.checkData,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.firstName}: ${state.firstName}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.lastName}: ${state.lastName}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.dateOfBirth}: ${state.dateOfBirth!.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.weight}: ${state.weight}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      '${AppLocalizations.of(context)!.height}:${state.height}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<OnboardingCubit>().saveUserData();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.finish,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return LoadingWidget();
            }
          },
          listener: (context, state) {
            if (state is OnboardingCompleted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                Routes.homeScreen,
                (Route<dynamic> route) => false,
              );
            }
          },
        ),
      ),
    );
  }
}
