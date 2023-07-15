import 'package:flutter/material.dart';
import 'package:rick_and_morty/service/api_client.dart';
import 'package:rick_and_morty/widget/call_back_field_widget.dart';
import 'package:rick_and_morty/widget/character_widget.dart';
import 'package:rick_and_morty/widget/future_updater_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.api});
  final ApiClient api;

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
    var themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('wubba lubba dub dub'),
        backgroundColor: themeData.colorScheme.background,
      ),
      body: ListView(
        children: [
          FutureUpdater(
            future: widget.api.getCharacter(characterID!),
            errorBuilder: (_, __, data) {
              return const Center(
                child: Text('Приключения на 20 минут, зашли и вышли'),
              );
            },
            loadingBuilder: (e) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            builder: (_, characters) {
              if (characters == null) {
                return const Center(
                  child: Text('Never gonna give you up'),
                );
              }
              return CharacterWidget(
                date: (characters.created),
                episode: (characters.episode[0]),
                image: (characters.image),
                location: (characters.location.name),
                name: (characters.name),
                species: (characters.species),
                status: (characters.status),
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
