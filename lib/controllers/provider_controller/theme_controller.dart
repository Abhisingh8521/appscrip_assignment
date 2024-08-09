import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../theme/dark_mode.dart';
import '../../theme/light_mode.dart';


class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = darkMode;
  final String themeKey = "theme";
  SharedPreferences? _prefs;

  ThemeProvider() {
    _loadFromPrefs();
  }

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    try{
      _themeData = themeData;
      _saveToPrefs();
      notifyListeners();
    }catch(e){
      print("Error : $e");
    }

  }

  void toggleTheme() {
    try{
      if (_themeData == lightMode) {
        themeData = darkMode;
      } else {
        themeData = lightMode;
      }
    }catch(e){
      print("Error : $e");
    }

  }

  _initPrefs() async {
    try{
      if (_prefs == null) {
        _prefs = await SharedPreferences.getInstance();
      }
    }catch(e){
      print("Error : $e");
    }

  }

  _loadFromPrefs() async {
    try{
      await _initPrefs();
      bool? isDark = _prefs?.getBool(themeKey);
      if (isDark != null) {
        _themeData = isDark ? darkMode : lightMode;
        notifyListeners();
      }
    }catch(e){
      print("Error : $e");
    }

  }

  _saveToPrefs() async {
    try{
      await _initPrefs();
      _prefs?.setBool(themeKey, _themeData == darkMode);
    }catch(e){
      print("Error : $e");
    }

  }
}
