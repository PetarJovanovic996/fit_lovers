import 'package:fit_lovers/core/my_theme.dart';
import 'package:fit_lovers/core/routes.dart';
import 'package:fit_lovers/data/repositories/user_repository.dart';
import 'package:fit_lovers/domain/cubit/authentication/auth_cubit.dart';
import 'package:fit_lovers/domain/cubit/cubit/onboarding_cubit.dart';
import 'package:fit_lovers/domain/cubit/settings/language_cubit.dart';
import 'package:fit_lovers/domain/cubit/settings/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
            create: (context) => OnboardingCubit(
                  userRepository: UserRepository(),
                ))
      ],
      //jezik , tema, rute
      child: AppConfiguration(),
    );
  }
}

class AppConfiguration extends StatelessWidget {
  const AppConfiguration({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          locale: (state is LanguageChanged)
              ? state.locale
              : const Locale('en', 'US'),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('sr', 'RS'),
          ],
          theme: MyTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          title: 'Named Routes',
          onGenerateRoute: MyRouter.onGenerateRoute,
        );
      },
    );
  }
}
