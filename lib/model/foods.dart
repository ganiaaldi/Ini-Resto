class Foods {
  late String name;

  Foods({
    required this.name,
  });

  Foods.fromJson(Map<String, dynamic> foods) {
    name = foods['name'].toString();
  }
}