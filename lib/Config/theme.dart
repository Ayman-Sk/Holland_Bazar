import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const primaryColor = Color(0xFFFE5A01);
const primarySwatch = MaterialColor(0xFFFE5A01, {
  50: Color(0xFFFE5A01),
  100: Color(0xFFFE5A01),
  200: Color(0xFFFE5A01),
  300: Color(0xFFFE5A01),
  400: Color(0xFFFE5A01),
  500: Color(0xFFFE5A01),
  600: Color(0xFFFE5A01),
  700: Color(0xFFFE5A01),
  800: Color(0xFFFE5A01),
  900: Color(0xFFFE5A01),
});
final ligthTheme = ThemeData(
    fontFamily: '',
    primaryColor: primaryColor,
    iconTheme: const IconThemeData(color: primaryColor),
    primarySwatch: primarySwatch,
    scaffoldBackgroundColor: const Color(0xFFFBFAFC),
    unselectedWidgetColor: Colors.grey,
    elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(overlayColor: MaterialStateProperty.all<Color?>(primaryColor.withOpacity(0.1)))),
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: primaryColor,
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        surfaceTintColor: Colors.transparent),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: primarySwatch).copyWith(secondary: const Color(0xFF231D25), brightness: Brightness.light),
    useMaterial3: true);
