import 'package:fit_lovers/presentations/screens/edit_profile_screen.dart';
import 'package:fit_lovers/presentations/screens/home_screen.dart';
import 'package:fit_lovers/presentations/screens/onboarding_screen.dart';
import 'package:fit_lovers/presentations/screens/register_screen.dart';
import 'package:fit_lovers/presentations/screens/welcome_view_screen.dart';
import 'package:flutter/material.dart';

// Routes always separate words by -
// add-new, login-screen

// This is good but when routing to named routes, we can make typos when typing,
// and so there is even a better way to do it:

// Instead of using
// Navigator.of(context).pushNamed('expenses')

// we can use
// Navigator.of(context).pushNamed(Routes.expenses)

// this way only Routes class hold the concrete string, and serves as single source of truth
// meaning, if we want to update the name of a route, we only update in one single place
// instead of the entire code where we pushed to that route.

// done: Replace all hardcoded route names in project with these
class Routes {
  static const String welcomeViewScreen = 'welcome-view';
  static const String logInScreen = 'logIn-screen';
  static const String registerScreen = 'register-screen';
  static const String onboardingScreen = 'onboarding-screen';
  static const String homeScreen = 'home-screen';
  static const String editProfileScreen = 'edit-profile-screen';
}

// BONUS:

// Rather than declaring routes by their names and create mappings, we can utilize
// [onGenerateRoute] method. Check [my_app.dart] to see how the implementation works.
// I will refactor and comment out current implementation to show how this could work.

class MyRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (BuildContext context) {
        return switch (routeSettings.name) {
          (Routes.welcomeViewScreen) => const WelcomeViewScreen(),
          //(Routes.logInScreen) => LogInScreen(),
          (Routes.registerScreen) => RegisterScreen(),
          (Routes.onboardingScreen) => const OnboardingScreen(),
          (Routes.homeScreen) => const HomeScreen(),
          (Routes.editProfileScreen) => const EditProfileScreen(),
          // Default route
          _ => const WelcomeViewScreen(),
        };
      },
    );
  }
}
