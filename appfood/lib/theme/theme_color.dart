import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xfffcaf03, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xfffcaf03), //10%
      100: const Color(0xffe39e03), //20%
      200: const Color(0xffca8c02), //30%
      300: const Color(0xffb07a02), //40%
      400: const Color(0xff976902), //50%
      500: const Color(0xff7e5802), //60%
      600: const Color(0xff654601), //70%
      700: const Color(0xff4c3401), //80%
      800: const Color(0xff322301), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
