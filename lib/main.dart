import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_project/firebase_options.dart';
import 'package:second_project/helper/bloc_observer.dart';
import 'package:second_project/helper/get_it.dart';
import 'package:second_project/helper/local_data/shared_pref.dart';
import 'package:second_project/best_app.dart';
import 'package:second_project/home_screen/data/local_notification_services.dart';
import 'package:second_project/home_screen/data/push_notification_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await EasyLocalization.ensureInitialized();
  await PushNotificationServices.init();
  await LocalNotificationService.init();
  getItSetUp();
  Bloc.observer = SimpleBlocObserver();
  await CashedSharedPrefrances.cachInitialization();
  CashedSharedPrefrances.getData(key: 'token');

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        path: 'assets/translation',
        fallbackLocale: const Locale('en'),
        child: const BestApp()),
  );
}
