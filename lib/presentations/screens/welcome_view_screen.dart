import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/presentations/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeViewScreen extends StatelessWidget {
  const WelcomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: (AppLocalizations.of(context)!.welcome),
        showSignOut: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/test.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: const _WelcomeButtons(),
      ),
    );
  }
}

class _WelcomeButtons extends StatelessWidget {
  const _WelcomeButtons();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.registerScreen),
                child: Text(
                  AppLocalizations.of(context)!.register,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.logInScreen),
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(Routes.homeScreen),
            child: Text(
              AppLocalizations.of(context)!.skip,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
