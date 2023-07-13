// Знаю, что кидать эти функции в виджет не стоит,
// лучше вычислить локации где-то отдельно
// (или просто нормально посмотреть api)
// Добавил, чтобы локация и дата отображались корректно,
// а не в виде Location(...) и без приписок после даты

String getLocation(String str) {
  List<String> letters = str.split('');
  int firstIndex = letters.indexOf(':');
  int secondIndex = letters.indexOf(',');
  String location = letters.sublist(firstIndex + 2, secondIndex).join();
  return location;
}

String getDate(String str) {
  List<String> letters = str.split('');
  String date = letters.sublist(0, letters.indexOf('T')).join();
  return date;
}

// Немного подробнее глянул модельку, которую сделал Саша
// Попозже переделаю и будет, как надо