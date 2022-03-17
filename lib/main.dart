import 'package:flutter/material.dart';
import 'package:fraction/theme/theme.dart';
import 'package:fraction/views/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      title: 'Fraction',
      themeMode: ThemeMode.dark,
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    ),
  );
}
