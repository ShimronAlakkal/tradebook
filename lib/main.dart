import 'package:flutter/material.dart';
import 'package:pron/theme/theme.dart';
import 'package:pron/views/home.dart';

void main() {
  runApp(
    MaterialApp(
      themeMode: ThemeMode.light,
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const Home(),
    ),
  );
}
