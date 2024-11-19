import 'package:flutter/material.dart';
import 'package:themed/themed.dart';

class MyTheme {
  static const backgroundColor = ColorRef(Color(0xFFEBE9E0));
  static const foregroundColor = ColorRef(Color(0xFF00508C));
  static const dialogColor = ColorRef(Color(0xCCA3B6A3));
  static const textColor = ColorRef(Colors.black, id: 'textColor');
  static const reverseColor = ColorRef(Colors.black, id: 'reverseColor');

  static const coverColor = ColorRef(Colors.green, id: 'coverColor');


  static const deleteColor = ColorRef(Color(0xFFA31105), id: 'deleteColor');
  static const archiveColor = ColorRef( Color(0xFF696969), id: 'archiveColor');



  static const type1Color = ColorRef(Color(0xFFD32F2F));
  static const type2Color = ColorRef(Color(0xFF1976D2));
  static const type3Color = ColorRef(Color(0xFFF57C00));
  static const type4Color = ColorRef(Color(0xFF9E9E9E));

  static const task1Color = ColorRef(Color(0xFFB31414));
  static const task2Color = ColorRef(Color(0xFFB34242));
  static const task3Color = ColorRef(Color(0xFF1431B3));
  static const task4Color = ColorRef(Color(0xFF146AB3));
  static const task5Color = ColorRef(Color(0xFF6A14B3));
  static const task6Color = ColorRef(Color(0xFF8A5EB3));
  static const task7Color = ColorRef(Color(0xFFB3146A));
  static const task8Color = ColorRef(Color(0xFFB3428A));
  static const task9Color = ColorRef(Color(0xFFDEFFA2));
  static const task15Color = ColorRef(Color(0xFF638E67));
  static const task10Color = ColorRef(Color(0xFF88A562));
  static const task11Color = ColorRef(Color(0xFF14B374));
  static const task12Color = ColorRef(Color(0xFFB36A14));
  static const task13Color = ColorRef(Color(0xFFB38F14));
  static const task14Color = ColorRef(Color(0xFFD9A514));

  // light themes

  static const lightTheme1Color = ColorRef(Color(0xFF004D40),id: 'light_theme8');
  static const lightTheme2Color = ColorRef(Color(0xFF20263F),id: 'light_theme1');
  static const lightTheme3Color = ColorRef(Color(0xFF49000F),id: 'light_theme2');
  static const lightTheme4Color = ColorRef(Color(0xFF4A148C),id: 'light_theme5');
  static const lightTheme5Color = ColorRef(Color(0xFF880E4F),id: 'light_theme7');
  static const lightTheme6Color = ColorRef(Color(0xFF444E33),id: 'light_theme3');
  static const lightTheme7Color = ColorRef(Color(0xFF5E8862),id: 'light_theme4');
  static const lightTheme8Color = ColorRef(Color(0xFFE65100),id: 'light_theme6');
  static const lightTheme9Color = ColorRef(Color(0xFF424242),id: 'light_theme9');

}

Map<ThemeRef, Object> GreenTheme = {
  MyTheme.backgroundColor: Color(0xFFF3F3F3),
  MyTheme.foregroundColor: Color(0xFF444E33),
  MyTheme.dialogColor: const Color(0xCC757A6B),
  MyTheme.textColor: const Color(0xCC5D705D),
  MyTheme.coverColor: const Color(0xFFB2D480),
};


Map<ThemeRef, Object> BlueTheme = {
  MyTheme.backgroundColor: const Color(0xFFDCCEBB),
  MyTheme.foregroundColor: const Color(0xFF20263F),
  MyTheme.dialogColor: const Color(0xCC656771),
  MyTheme.coverColor: const Color(0xCC3562FF),
};

Map<ThemeRef, Object> RedTheme = {
  MyTheme.backgroundColor: const Color(0xFFE0D4BB),
  MyTheme.foregroundColor: const Color(0xFF49000F),
  MyTheme.dialogColor: const Color(0xCC574146),
  MyTheme.coverColor: const Color(0xCCFF0000),
};


Map<ThemeRef, Object> DefaultTheme = {
  MyTheme.backgroundColor: const Color(0xFFEBE9E0),
  MyTheme.foregroundColor: const Color(0xFF5E8862),
  MyTheme.dialogColor: const Color(0xCCA3B6A3),
};




// test themes


Map<ThemeRef, Object> PurpleTheme = {
  MyTheme.backgroundColor: const Color(0xFFEDE7F6),
  MyTheme.foregroundColor: const Color(0xFF4A148C),
  MyTheme.dialogColor: const Color(0x59673AB7),
  MyTheme.textColor: const Color(0xFF9575CD),
  MyTheme.coverColor: const Color(0xFF7B1FA2),
};

Map<ThemeRef, Object> OrangeTheme = {
  MyTheme.backgroundColor: const Color(0xFFFFF3E0),
  MyTheme.foregroundColor: const Color(0xFFDF6F32),
  MyTheme.dialogColor: const Color(0x59FF8A65),
  MyTheme.textColor: const Color(0xFFF57C00),
  MyTheme.coverColor: const Color(0xFFFF6D00),
};


Map<ThemeRef, Object> PinkTheme = {
  MyTheme.backgroundColor: const Color(0xFFFCE4EC),
  MyTheme.foregroundColor: const Color(0xFF880E4F),
  MyTheme.dialogColor: const Color(0x59F06292),
  MyTheme.textColor: const Color(0xFFD81B60),
  MyTheme.coverColor: const Color(0xFFC2185B),
};


Map<ThemeRef, Object> TealTheme = {
  MyTheme.backgroundColor: const Color(0xFFE0F2F1),
  MyTheme.foregroundColor: const Color(0xFF004D40),
  MyTheme.dialogColor: const Color(0x5980CBC4),
  MyTheme.textColor: const Color(0xFF00796B),
  MyTheme.coverColor: const Color(0xFF00AE91),
};



Map<ThemeRef, Object> GrayTheme = {
  MyTheme.backgroundColor: const Color(0xFFF5F5F5),
  MyTheme.foregroundColor: const Color(0xFF424242),
  MyTheme.dialogColor: const Color(0xCC9E9E9E),
  MyTheme.textColor: const Color(0xFF616161),
  MyTheme.coverColor: const Color(0xFF757575),
};

