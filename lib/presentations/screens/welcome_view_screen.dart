import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/presentations/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeViewScreen extends StatelessWidget {
  const WelcomeViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //prvi pokusaj prevoda
      appBar: CustomAppBar(
        title: (AppLocalizations.of(context)!.welcome),
        showSignOut: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/test.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: _WelcomeButtons(),
        // Register, Login, Skip Buttons
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
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(Routes.logInScreen),
                child: Text(
                  AppLocalizations.of(context)!.login,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushNamed(Routes.homeScreen),
            child: Text(
              AppLocalizations.of(context)!.skip,
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
