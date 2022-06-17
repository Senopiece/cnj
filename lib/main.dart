import 'dart:async';

import 'package:cnj/pages/jokes.dart';
import 'package:cnj/themes/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as flutter_services;
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'services/binding.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    flutter_services.SystemChrome.setPreferredOrientations([
      flutter_services.DeviceOrientation.portraitUp,
    ]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(const ChuckNorrisJokeApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
  });
}

class ChuckNorrisJokeApp extends StatelessWidget {
  const ChuckNorrisJokeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chuck Norris jokes!',
      theme: mainTheme,
      initialBinding: ServicesBinding(),
      initialRoute: jokesPage.name,
      getPages: [
        jokesPage,
      ],
    );
  }
}
