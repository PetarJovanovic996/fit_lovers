import 'package:fit_lovers/app_bloc_observer.dart';
import 'package:fit_lovers/core/firebase_options.dart';
import 'package:fit_lovers/core/my_theme.dart';
import 'package:fit_lovers/cubit/settings/language_cubit.dart';
import 'package:fit_lovers/cubit/settings/language_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            // locale:
            //     (state is LanguageChanged) ? state.locale : Locale('en', 'US'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              Locale('en', 'US'),
              Locale('sr', 'RS'),
            ],

            locale: Locale('sr', 'RS'),
            theme: MyTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            title: 'Named Routes',

            onGenerateRoute: MyRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
