import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const defaultTheme = ThemeMode.system;

Future<void> saveThemeMode(ThemeMode mode) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString('theme_mode', mode.index.toString());
}

Future<ThemeMode> loadThemeMode(SharedPreferences? pref) async {
  if (pref != null) {
    return toMode(
        pref.getString('theme_mode') ?? defaultTheme.index.toString());
  }
  final pref1 = await SharedPreferences.getInstance();
  return toMode(pref1.getString('theme_mode') ?? defaultTheme.index.toString());
}

ThemeMode toMode(String str) {
  return ThemeMode.values.where((val) => val.name == str).first;
}

extension ThemeModeEx on ThemeMode {
  String get key => toString().split('.').first;
  String get name => toString().split('.').last;
}
