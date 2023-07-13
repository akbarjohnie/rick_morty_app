import 'package:flutter/material.dart';
import 'package:rick_and_morty/func/functions.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({
    super.key,
    required this.episode,
    required this.image,
    required this.date,
    required this.species,
    required this.status,
    required this.location,
    required this.name,
  });

  final episode;
  final String image;
  final String date;
  final String name;
  final String species;
  final String status;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Эпизод: ${episode[0].split('/').last}'),
          Image.network(image),
          Text("Дата: ${getDate(date)}"),
          Text("Имя: $name"),
          Text("Расса: $species"),
          Text("Статус: $status"),
          Text(
            "Локация: ${getLocation(location.toString())}",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
