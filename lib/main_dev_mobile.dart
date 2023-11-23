import 'package:flutter/material.dart';
import 'package:sandfriends_web/app.dart';
//import 'firebase_options_dev.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  runApp(const App(
    flavor: "dev",
  ));
}
