import 'package:as_news/models/trending_model.dart';
import 'package:as_news/utils/services/api_services.dart';
import 'package:flutter/material.dart';

class ApiProvider extends ChangeNotifier {
  bool _isLoading = true;
  get isLoading => _isLoading;
 var _trendingNews = [];
  get trendingNews => _trendingNews;

  notifyListeners();
  Future getTrending() async {
    try {
      final response = await DioRequestServices().getTrending();
      print(response);
      if (response["sucesss"]) {
        _trendingNews = response['data'];
        print(_trendingNews[0].status);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
