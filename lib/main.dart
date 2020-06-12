import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poolheatercalculator/app_language.dart';
import 'package:poolheatercalculator/core/services/authentication_service.dart';
import 'package:poolheatercalculator/core/utils/shared_pref_util.dart';
import 'package:poolheatercalculator/localization.dart';
import 'package:poolheatercalculator/ui/router.dart';
import 'package:poolheatercalculator/ui/views/home_view.dart';
import 'package:poolheatercalculator/ui/views/intro_view.dart';
import 'package:poolheatercalculator/ui/views/login_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  setupLocator();
  bool shouldShowMessageAgain = await SharedPrefUtil.shouldShowMessageAgain();
  AuthenticationService authenticationServie = locator<AuthenticationService>();
  String user = await authenticationServie.getCurrentUser();
  runApp(MyApp(
      appLanguage: appLanguage,
      shouldShowMessageAgain: shouldShowMessageAgain,
      user: user));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;
  final bool shouldShowMessageAgain;
  final String user;

  MyApp({this.appLanguage, this.shouldShowMessageAgain, this.user});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (BuildContext context) {
        return appLanguage;
      },
      child: Consumer<AppLanguage>(
        builder: (BuildContext context, AppLanguage value, Widget child) {
          print('notified ${value.appLocal}');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            title: 'Calculated Pool Heater List',
            navigatorObservers: [BotToastNavigatorObserver()],
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: value.appLocal,
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('it', 'IT'), // Italian
              const Locale('fr', 'FR'), // French
              const Locale('es', 'ES'), // Spanish
              const Locale('pt', 'BR'), // Portuguese
              // ... other locales the app supports
            ],
            onGenerateRoute: Router.generateRoute,
            initialRoute: shouldShowMessageAgain
                ? IntroductionView.pathName
                : user != null ? HomeView.pathName : LoginView.pathName,
          );
        },
      ),
    );
  }
}
