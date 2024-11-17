import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
  static const backgroundColor = ColorRef(Color(0xFFEBE9E0));
  static const foregroundColor = ColorRef(Color(0xFF5E8862));
  static const dialogColor = ColorRef(Color(0xCCA3B6A3));
  static const textColor = ColorRef(Colors.black, id: 'textColor');
  static const reverseColor = ColorRef(Colors.black, id: 'reverseColor');


  static const deleteColor = ColorRef(Color(0xFFA31105), id: 'deleteColor');
  static const archiveColor = ColorRef( Color(0xFF696969), id: 'archiveColor');



  static const type1Color = ColorRef(Color(0xFFD32F2F));
  static const type2Color = ColorRef(Color(0xFF1976D2));
  static const type3Color = ColorRef(Color(0xFFF57C00));
  static const type4Color = ColorRef(Color(0xFF9E9E9E));

  static const task1Color = ColorRef(Color(0xFFB31414));  // Deep Red
  static const task2Color = ColorRef(Color(0xFFB34242));  // Soft Red
  static const task3Color = ColorRef(Color(0xFF1431B3));  // Deep Blue
  static const task4Color = ColorRef(Color(0xFF146AB3));  // Soft Blue
  static const task5Color = ColorRef(Color(0xFF6A14B3)); // Deep Purple
  static const task6Color = ColorRef(Color(0xFF8A5EB3)); // Soft Lavender
  static const task7Color = ColorRef(Color(0xFFB3146A));  // Deep Pink
  static const task8Color = ColorRef(Color(0xFFB3428A)); // Soft Pink
  static const task9Color = ColorRef(Color(0xFFDEFFA2)); // Soft Pink
  static const task15Color = ColorRef(Color(0xFF638E67)); // Earthy Green
  static const task10Color = ColorRef(Color(0xFF88A562)); // Sage Green
  static const task11Color = ColorRef(Color(0xFF14B374));  // Soft Teal
  static const task12Color = ColorRef(Color(0xFFB36A14)); // Warm Orange
  static const task13Color = ColorRef(Color(0xFFB38F14));  // Warm Gold
  static const task14Color = ColorRef(Color(0xFFD9A514));  // Light Gold
}

Map<ThemeRef, Object> GreenTheme = {
  MyTheme.backgroundColor: Color(0xFFF3F3F3),
  MyTheme.foregroundColor: Color(0xFF444E33),
  MyTheme.dialogColor: const Color(0xCC757A6B),
  MyTheme.textColor: const Color(0xCC5D705D),


};


Map<ThemeRef, Object> BlueTheme = {
  MyTheme.backgroundColor: const Color(0xFFDCCEBB),
  MyTheme.foregroundColor: const Color(0xFF20263F),
  MyTheme.dialogColor: const Color(0xCC656771),

};

Map<ThemeRef, Object> RedTheme = {
  MyTheme.backgroundColor: const Color(0xFFE0D4BB),
  MyTheme.foregroundColor: const Color(0xFF49000F),
  MyTheme.dialogColor: const Color(0xCC574146),

};










