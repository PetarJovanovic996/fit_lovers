import 'package:fit_lovers/core/app_bloc_observer.dart';
import 'package:fit_lovers/core/firebase_options.dart';
import 'package:fit_lovers/core/my_app.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
