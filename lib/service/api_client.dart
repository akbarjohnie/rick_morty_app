import 'package:dio/dio.dart';
import 'package:rick_and_morty/model/character.dart';
import 'package:rick_and_morty/service/api_service.dart';

class ApiClient {
  final dio = Dio();

  Future<Character> getCharacter(int id) async {
    dio.options.baseUrl = 'https://rickandmortyapi.com';
    final api = RestClient(dio);
    Future<Character> ch = api.getCharacterData(id);
    return (await ch);
  }
}

// По неизвестной мне причине "ch" не хочет обозначаться как await