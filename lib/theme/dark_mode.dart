import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
      appBarTheme: AppBarTheme(
            color:Color(0xff2a2d3d)
      ),
    popupMenuTheme: PopupMenuThemeData(
          color: Colors.blue,
          surfaceTintColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
    ),

    colorScheme: ColorScheme.dark(
      background: Color(0xff212332),
      primary: Colors.white,
      secondary: Color(0xff2a2d3d),
      onPrimary: Colors.white,
      tertiary: Colors.blue,
      inversePrimary: Colors.grey.shade300,


    )
);