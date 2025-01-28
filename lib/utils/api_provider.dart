import 'package:flutter/material.dart';
import 'package:as_news/models/trending_model.dart';
import 'package:as_news/utils/services/api_services.dart';
class ApiProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<Article> _trendingNews = [];
  String _error = '';

  List<Article> get trendingNews => _trendingNews;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> getTrending() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final response = await DioRequestServices().getTrending();
      if (response["sucesss"]) {
        _trendingNews = response['data'];
      } else {
        _error = 'Failed to load trending news.';
      }
    } catch (e) {
      _error = 'Error fetching data: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}