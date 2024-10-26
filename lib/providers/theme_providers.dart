import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<bool>((ref) => false);

final themeDataProvider = Provider<ThemeData>((ref) {
  bool isDarkMode = ref.watch(themeProvider);
  return isDarkMode ? ThemeData.dark() : ThemeData.light();
});
