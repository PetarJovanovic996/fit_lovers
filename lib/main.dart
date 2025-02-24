import 'package:fit_lovers/core/app_bloc_observer.dart';
import 'package:fit_lovers/core/my_theme.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';
import 'package:fit_lovers/presentations/cubit/onboarding/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// done: moved to presentation layer
//Cubits should not be defined / nor logically are a part of the "Domain" layer
// Cubits handle presentation (UI) layer logic. Do not overcomplicate at the moment

Future<void> main() async {
  // Future<void> clearData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // } // za test

  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(MyApp(authenticationRepository: authenticationRepository));
  //clearData za test
}

class MyApp extends StatelessWidget {
  const MyApp({
    required AuthenticationRepository authenticationRepository,
    super.key,
  }) : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LanguageCubit(),
          ),
          BlocProvider(
            create: (context) =>
                OnboardingCubit(userRepository: UserRepository()),
          ),
        ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              locale: (state is LanguageChanged) ? state.locale : Locale('en'),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // done: When declaring locales we can only use the language code and omit the country code
              // Locale('sr'), Locale('en')
              supportedLocales: [
                Locale('en'),
                Locale('sr'),
              ],
              theme: MyTheme.lightTheme,
              debugShowCheckedModeBanner: false,
              title: 'Fit Lovers',

              onGenerateRoute: MyRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
}
