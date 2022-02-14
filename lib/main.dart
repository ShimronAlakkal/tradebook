import 'package:flutter/material.dart';
import 'package:pron/theme/theme.dart';
import 'package:pron/views/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      themeMode: ThemeMode.dark,
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    ),
  );
}
