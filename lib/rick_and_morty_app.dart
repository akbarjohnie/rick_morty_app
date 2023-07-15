import 'package:flutter/material.dart';
import 'package:rick_and_morty/pages/screen_page.dart';
import 'package:rick_and_morty/service/api_client.dart';

class RickAndMortyApp extends StatelessWidget {
  const RickAndMortyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(
        api: ApiClient(),
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2CFF65),
          background: const Color(0xFFEDEDED),
          surface: const Color(0xFFFFFFFF),
          error: const Color(0xFFF85535),
        ),
      ),
    );
  }
}
