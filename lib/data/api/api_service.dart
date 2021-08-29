import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ini_resto/data/model/customer_review.dart';
import 'package:ini_resto/data/model/restaurant.dart';


class ApiService {
  static final String baseUrl = 'https://restaurant-api.dicoding.dev/';
  static final String list = 'list';

  final http.Client client;
  ApiService(this.client);

  Future<ListRestaurant> restaurantList() async {
    final response = await client.get(Uri.parse(baseUrl + list));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan data daftar restaurant.');
    }
  }

  Future<ListDetailRestaurant> restaurantDetail(String id) async {
    final response = await client.get(Uri.parse(baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return ListDetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal mendapatkan data detail restaurant.');
    }
  }

  Future<ResultRestaurant> searchRestaurant(String query) async {
    final response = await client.get(Uri.parse(baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return ResultRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal Mencari Data Restaurant.');
    }
  }

  Future<ResponseReview> postReview(CustomerReview review) async {
    var _review = jsonEncode(review.toJson());
    final response = await client.post(
      Uri.parse(baseUrl + "review"),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );
    if (response.statusCode == 200) {
      return ResponseReview.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post the review.');
    }
  }
}