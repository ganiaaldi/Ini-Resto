class Drinks {
  late String name;

  Drinks({
    required this.name,
  });

  Drinks.fromJson(Map<String, dynamic> foods) {
    name = foods['name'];
  }
}