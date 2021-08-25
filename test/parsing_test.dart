import 'package:flutter_test/flutter_test.dart';
import 'package:ini_resto/data/api/api_service.dart';
import 'package:ini_resto/data/model/restaurant.dart';

void main() {
  test('Response restaurant', () async {
    final getList = await ApiService().restaurantList();
    var result = getList.message;
    expect(result, "success");
  });
  test("Test Parsing Restaurant ID", () async {
    var result = Restaurant.fromJson(testParsing).id;
    expect(result, "uewq1zg2zlskfw1e867");
  });
  test('Fetch name restaurant', () async {
    final getList = await ApiService().restaurantList();
    var result = getList.restaurants[0];
    expect(result.name, "Melting Pot");
  });
  test('Fetch total restaurant', () async {
    final getList = await ApiService().restaurantList();
    var result = getList.count;
    expect(result, 20);
  });
}

var testParsing = {
  "id": "uewq1zg2zlskfw1e867",
  "name": "Kafein",
  "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
  "pictureId": "15",
  "city": "Aceh",
  "rating": 4.6
};