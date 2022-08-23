import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fraction/theme/theme.dart';
import 'package:fraction/views/home.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
