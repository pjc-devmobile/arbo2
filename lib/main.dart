// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/modules/core/app_module.dart';
import 'app/modules/core/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //PushNotification().configure();
  await Firebase.initializeApp();
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}