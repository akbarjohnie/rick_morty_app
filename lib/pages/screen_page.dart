import 'package:flutter/material.dart';
import 'package:rick_and_morty/service/api_client.dart';
import 'package:rick_and_morty/widget/call_back_field_widget.dart';
import 'package:rick_and_morty/widget/character_widget.dart';
import 'package:rick_and_morty/widget/future_updater_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? characterID;

  @override
  void initState() {
    super.initState();
    characterID = 1;
  }

  @override
  Widget build(BuildContext context) {
    final api = ApiClient();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('wubba lubba dub dub'),
      ),
      body: ListView(
        children: [
          FutureUpdater(
            future: api.getCharacter(characterID ?? 1),
            errorBuilder: (_, __, ___) {
              return const Center(
                child: Text('Приключения на 20 минут'),
              );
            },
            loadingBuilder: (e) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            builder: (_, characters) {
              return CharacterWidget(
                date: (characters?.created.toString() ?? ''),
                episode: (characters?.episode ?? 'hz'),
                image: (characters?.image ?? ''),
                location: (characters?.location.toString() ?? ''),
                name: (characters?.name ?? ''),
                species: (characters?.species ?? ''),
                status: (characters?.status ?? ''),
              );
            },
          ),
          CallBackFieldWidget(
            id: (chId) {
              setState(() {
                characterID = chId;
              });
            },
          )
        ],
      ),
    );
  }
}
