import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'design_system/const.dart';

class AppLocalizations {
  static String? myLang = '';

  static Future<String> getAppLang() async {
    final prefs = await SharedPreferences.getInstance();
    final startUpLang = prefs.getString('startUpLang');
    Const.appLang = startUpLang;
    myLang = startUpLang;
    if (startUpLang == null) {
      return 'en';
    } else {
      return '$startUpLang';
    }
  }

  static Future<void> resetCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('startUpLang', 'en');
  }

  static Future<void> changeStartUpLang(String newStartUpLang) async {
    final prefs = await SharedPreferences.getInstance();
    String lastStartUpLang = await getAppLang();
    String currentStartUpLang = newStartUpLang;

    await prefs.setString('startUpLang', currentStartUpLang);
  }
  // appLang() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String appLang = prefs.getString('en');
  //   print('Pressed $counter times.');
  //   await prefs.setInt('counter', counter);
  // }

  static String? userLocale;
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future load() async {
    await getAppLang();
    String jsonString =
        await rootBundle.loadString('lang/${await getAppLang()}.json');
    // await rootBundle.loadString('lang/${locale.languageCode}.json');
    userLocale = locale.languageCode;
    print(Const.appLang);
    print('=======> User Locale is $userLocale');
    print({'=======> Current Language is ${await getAppLang()}'});
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings?[key] ?? "TRANSLATE";
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ku', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
