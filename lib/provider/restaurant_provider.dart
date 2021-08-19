import 'package:flutter/material.dart';
import 'package:ini_resto/data/api/api_service.dart';
import 'dart:async';

import 'package:ini_resto/data/model/customer_review.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String type;
  final String id;

  RestaurantProvider({required this.apiService, required this.type, required this.id}) {
    if (type == 'list') {
      fetchAllRestaurant();
    } else if (type == 'detail') {
      fetchDetailRestaurant(id);
    }
  }

  late dynamic _restaurantResult;
  String _message = '';
  late ResultState _state;

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantList = await apiService.restaurantList();
      if (restaurantList.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Data Kosong';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurantList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Tidak dapat terhubung, mohon untuk mengecek kembali koneksi.';
    }
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantDetail = await apiService.restaurantDetail(id);
      _state = ResultState.HasData;
      notifyListeners();
      return _restaurantResult = restaurantDetail;
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Tidak dapat terhubung, mohon untuk mengecek kembali koneksi.';
    }
  }

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final searchRestaurant = await apiService.searchRestaurant(query);
      if (searchRestaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Pencarian Tidak Ditemukan.';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = searchRestaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Tidak dapat terhubung, mohon untuk mengecek kembali koneksi.';
    }
  }

  Future<dynamic> postReview(CustomerReview review) async {
    try {
      final response = await apiService.postReview(review);
      if (!response.error) fetchDetailRestaurant(review.id!);
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}