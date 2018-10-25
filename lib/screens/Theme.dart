import 'package:flutter/material.dart';

class Colors {

  const Colors();


  static const Color appBarTitle = const Color(0xFFFFFFFF);
  static const Color appBarIconColor = const Color(0xFFFFFFFF);
  static const Color appBarDetailBackground = const Color(0x00FFFFFF);
  static const Color appBarGradientStart = const Color(0xFFF44336);
  static const Color appBarGradientEnd = const Color(0xFFF44336);

  //static const Color planetCard = const Color(0xFF434273);
  static const Color regionCard = const Color(0xFFFFFFFF);
  //static const Color planetListBackground = const Color(0xFF3E3963);
  static const Color regionPageBackground = const Color(0xFFEEEEEE);
  static const Color planetTitle = const Color(0xFFF44336);
  static const Color planetLocation = const Color(0x66FFFFFF);
  static const Color planetDistance = const Color(0x66FFFFFF);

}

class Dimens {
  const Dimens();

  static const planetWidth = 100.0;
  static const planetHeight = 100.0;
}

class TextStyles {

  const TextStyles();

  static const TextStyle appBarTitle = const TextStyle(
      color: Colors.appBarTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 36.0
  );

  static const TextStyle regionTitle = const TextStyle(
      color: Colors.planetTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 22.0
  );

  static const TextStyle planetLocation = const TextStyle(
      color: Colors.planetLocation,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 14.0
  );

  static const TextStyle planetDistance = const TextStyle(
      color: Colors.planetDistance,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 12.0
  );

  static const TextStyle regionDistance2 = const TextStyle(
      color: Colors.planetTitle,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w300,
      fontSize: 13.0
  );


}
