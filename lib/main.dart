import 'package:flutter/material.dart';
import 'package:pron/theme/theme.dart';
import 'package:pron/views/Home.dart';

void main() {
  runApp(
    MaterialApp(
      themeMode: ThemeMode.dark ,
      theme: Palette.lightTheme,
      darkTheme: Palette.darkTheme,
      debugShowCheckedModeBanner: false,
      home: Home(),
    ),
  );
}
