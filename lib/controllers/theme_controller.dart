import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> _mode = ThemeMode.dark.obs;

  ThemeMode get themeMode => _mode.value;
  bool get isDark => _mode.value == ThemeMode.dark;

  void toggle() {
    _mode.value = isDark ? ThemeMode.light : ThemeMode.dark;
  }

  void setMode(ThemeMode mode) {
    _mode.value = mode;
  }
}
