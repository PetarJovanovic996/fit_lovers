import 'package:fit_lovers/core/app_bloc_observer.dart';
import 'package:fit_lovers/core/my_theme.dart';
import 'package:fit_lovers/data/models/language.dart';
import 'package:fit_lovers/data/repositories/authentication_repository.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';
import 'package:fit_lovers/data/services/exercises_service.dart';
import 'package:fit_lovers/presentations/cubit/exercises/exercise_cubit.dart';
import 'package:fit_lovers/presentations/cubit/exercises/filters_cubit.dart';
import 'package:fit_lovers/presentations/cubit/exercises/single_exercise_cubit.dart';
import 'package:fit_lovers/presentations/cubit/onboarding/onboarding_cubit.dart';
import 'package:fit_lovers/presentations/cubit/onboarding/onboarding_status/onboarding_status_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_cubit.dart';
import 'package:fit_lovers/presentations/cubit/settings/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/util/legacy_to_async_migration_util.dart';
import 'core/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  // Future<void> clearData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.clear();
  // } // za test

  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  const SharedPreferencesOptions sharedPreferencesOptions =
      SharedPreferencesOptions();
  final sharedPreferences = await SharedPreferences.getInstance();
  await migrateLegacySharedPreferencesToSharedPreferencesAsyncIfNecessary(
    legacySharedPreferencesInstance: sharedPreferences,
    sharedPreferencesAsyncOptions: sharedPreferencesOptions,
    migrationCompletedKey: 'migrationCompleted',
  );

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => OnboardingStatusCubit(
            sharedPreferences: sharedPreferences,
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => LanguageCubit(
            sharedPreferences: sharedPreferences,
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => ExerciseCubit(
            ExerciseService(),
          ),
        ),
        BlocProvider(
          create: (context) => SingleExerciseCubit(
            ExerciseService(),
          ),
        ),
        BlocProvider(
          create: (context) => FiltersCubit(),
        ),
      ],
      child: MyApp(
        authenticationRepository: authenticationRepository,
      ),
    ),
  );
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
            create: (context) =>
                OnboardingCubit(userRepository: UserRepository()),
          ),
        ],
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp(
              locale: state.locale,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              // done: When declaring locales we can only use the language code and omit the country code
              // Locale('sr'), Locale('en')
              // done: Why not utilize [language.dart] line: 14 ?
              supportedLocales: Language.supportedLanguages
                  .map((language) => language.locale)
                  .toList(),
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
