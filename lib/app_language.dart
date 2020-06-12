import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocal => _appLocale ?? Locale('en');

  fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      _appLocale = Locale('en');
      return Null;
    }
    _appLocale = Locale(prefs.getString('language_code'));
    return Null;
  }

  void changeLanguage(Locale type) async {
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale == type) {
      return;
    }
    if (type == Locale('it')) {
      _appLocale = Locale('it');
      await prefs.setString('language_code', 'it');
      await prefs.setString('countryCode', 'IT');
    } else if (type == Locale('fr')) {
      _appLocale = Locale('fr');
      await prefs.setString('language_code', 'fr');
      await prefs.setString('countryCode', 'FR');
    } else if (type == Locale('pt')) {
      _appLocale = Locale('pt');
      await prefs.setString('language_code', 'pt');
      await prefs.setString('countryCode', 'BR');
    } else if (type == Locale('es')) {
      _appLocale = Locale('es');
      await prefs.setString('language_code', 'es');
      await prefs.setString('countryCode', 'ES');
    } else {
      _appLocale = Locale('en');
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    notifyListeners();
  }
}
