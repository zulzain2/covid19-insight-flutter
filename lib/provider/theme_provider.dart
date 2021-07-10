import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'dart:math';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance!.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  // int tintValue(int value, double factor) =>
  //     max(0, min((value + ((255 - value) * factor)).round(), 255));

  // Color tintColor(Color color, double factor) => Color.fromRGBO(
  //     tintValue(color.red, factor),
  //     tintValue(color.green, factor),
  //     tintValue(color.blue, factor),
  //     1);

  // int shadeValue(int value, double factor) =>
  //     max(0, min(value - (value * factor).round(), 255));

  // Color shadeColor(Color color, double factor) => Color.fromRGBO(
  //     shadeValue(color.red, factor),
  //     shadeValue(color.green, factor),
  //     shadeValue(color.blue, factor),
  //     1);

  // MaterialColor generateMaterialColor(Color color) {
  //   return MaterialColor(color.value, {
  //     50: tintColor(color, 0.9),
  //     100: tintColor(color, 0.8),
  //     200: tintColor(color, 0.6),
  //     300: tintColor(color, 0.4),
  //     400: tintColor(color, 0.2),
  //     500: color,
  //     600: shadeColor(color, 0.1),
  //     700: shadeColor(color, 0.2),
  //     800: shadeColor(color, 0.3),
  //     900: shadeColor(color, 0.4),
  //   });
  // }

  static final darkTheme = ThemeData(
    primarySwatch: MaterialColor(Colors.blue.value, {
      50: Colors.blue.shade50,
      100: Colors.blue.shade100,
      200: Colors.blue.shade200,
      300: Colors.blue.shade300,
      400: Colors.blue.shade400,
      500: Colors.blue.shade500,
      600: Colors.blue.shade600,
      700: Colors.blue.shade700,
      800: Colors.blue.shade800,
      900: Colors.blue.shade900,
    }),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.white,
    colorScheme: ColorScheme.dark(secondary: Colors.blue),
    iconTheme: IconThemeData(color: Colors.blueAccent, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    primarySwatch: MaterialColor(Colors.blue.value, {
      50: Colors.blue.shade50,
      100: Colors.blue.shade100,
      200: Colors.blue.shade200,
      300: Colors.blue.shade300,
      400: Colors.blue.shade400,
      500: Colors.blue.shade500,
      600: Colors.blue.shade600,
      700: Colors.blue.shade700,
      800: Colors.blue.shade800,
      900: Colors.blue.shade900,
    }),
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    colorScheme:
        ColorScheme.light(secondary: Colors.blue),
    iconTheme: IconThemeData(color: Colors.blueAccent, opacity: 0.8),
  );
}
