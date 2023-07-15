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

  final String episode;
  final String image;
  final String date;
  final String name;
  final String species;
  final String status;
  final String location;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 10.0,
        shadowColor: (status == "Alive")
            ? themeData.colorScheme.primary
            : themeData.colorScheme.error,
        color: themeData.colorScheme.surface,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              image,
              errorBuilder: (context, error, stackTrace) {
                return const Divider(
                  height: 0,
                );
              },
            ),
            Text("Имя: $name"),
            Text("Дата добавления персонажа в db: ${getDate(date)}"),
            Text('Первое появление в эпизоде №${episode.split('/').last}'),
            Text(
              "Локация: $location",
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Расса: $species"),
                const SizedBox(
                  width: 5.0,
                ),
                if (status != 'unknown')
                  Icon(
                    Icons.circle,
                    color: Color(
                      (status == 'Alive') ? 0xFF4CAF50 : 0xFFF44336,
                    ),
                    size: 15.0,
                  ),
                if (status == 'unknown')
                  const Icon(
                    Icons.question_mark,
                    color: Color(0xFF9C27B0),
                    size: 15.0,
                  ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
