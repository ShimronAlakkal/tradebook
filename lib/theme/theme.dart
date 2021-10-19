import 'package:flutter/material.dart';

class Palette {
  static final lightTheme = ThemeData(
    backgroundColor: const Color(0xffE5E5E5),
    primaryColor: const Color(0xff474A2C),
    colorScheme: const ColorScheme.light(),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 25,
    ),
  );

  static final darkTheme = ThemeData(
    backgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(),
    iconTheme: const IconThemeData(
      color: Colors.white,
      size: 25,
    ),
  );
}



// Purple #5d13e7
// Teal #7ad9f5
// Light green #7ad9f5
// Shade of white #f6f6f6
//  green for indicators #66d37e
//  red for indicators




// alternative purple #9b77da
// accent color #9b77da
// primary #4e6b9f
//  grey for touches #6fa5b1


// AB9AFF buttons
// cards 6C61B8
// trade symobl 00C89B (green)
// bg E5E5E5
// Button accent CDC7EE