// Знаю, что кидать эти функции в виджет не стоит,
// лучше вычислить локации где-то отдельно
// (или просто нормально посмотреть api)
// Добавил, чтобы локация и дата отображались корректно,
// а не в виде Location(...) и без приписок после даты

String getDate(String str) {
  List<String> letters = str.split('');
  String date = letters.sublist(0, letters.indexOf('T')).join();
  return date;
}

// Немного подробнее глянул модельку, которую сделал Саша
// Попозже переделаю и будет, как надо

// getLocation перестала быть нужной, т.к. чуть лучше посмотрел апи