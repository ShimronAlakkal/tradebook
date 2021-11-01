import 'package:flutter/material.dart';
import 'package:pron/theme/theme.dart';
import 'package:pron/views/home.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

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
