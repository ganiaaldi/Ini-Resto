import 'drinks.dart';
import 'foods.dart';

class Menus {
  late List<Menu> foods;
  late List<Menu> drinks;

  Menus({required this.foods, required this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    List<dynamic> foods = json['foods'];
    List<dynamic> drinks = json['drinks'];
    this.foods = List.from(foods.map((food) => Menu.fromJson(food)));
    this.drinks = List.from(drinks.map((drink) => Menu.fromJson(drink)));
  }
}

class Menu {
  late String name;
  Menu({required this.name});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}