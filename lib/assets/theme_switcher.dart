import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwitchThemeWidget extends StatelessWidget {
  const SwitchThemeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = context.watch<ValueNotifier<ThemeMode>>();
    return IconButton(
      onPressed: () {
        themeNotifier.value = themeNotifier.value == ThemeMode.dark
            ? ThemeMode.light
            : ThemeMode.dark;
      },
      icon: Icon(
        themeNotifier.value == ThemeMode.dark
            ? Icons.dark_mode
            : Icons.light_mode,
      ),
    );
  }
}
