import 'dart:developer';

import 'package:as_news/models/trending_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// class GetTrendingService {
//   static final apiKey = dotenv.env['NEWS_API_KEY'];
//   var client = http.Client();

//   final url = Uri.parse(
//       "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey");

//   Future<List<TrendingModel>> getAll() async {
//     try {
//       final response = await client.get(url);
//       // print(response.body);
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data.map((post) => TrendingModel.fromJson(post)).toList();
//       } else {
//         throw Exception(
//             'Failed to load posts. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Error occurred: $e');
//     }
//   }

class DioRequestServices {
  static final apiKey = dotenv.env['NEWS_API_KEY'];
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org/v2",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {Headers.contentTypeHeader: "application/json"},
    ),
  );
  DioRequestServices() {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // ignore: unnecessary_brace_in_string_interps
      log("Sending Request to: ${options} ");
      return handler.next(options);
    }, onResponse: (Response response, ResponseInterceptorHandler handler) {
      log("Received response: ${response.statusCode}");
      return handler.next(response);
    }, onError:
            (DioException exception, ErrorInterceptorHandler handler) async {
      int retryCount = 0;
      int maximumRetries = 3;
      while (retryCount < maximumRetries &&
          exception.type == DioExceptionType.connectionTimeout) {
        retryCount++;
        try {
          log("Connection timeout,retrying $retryCount");
          final res = await dio.request(exception.requestOptions.path);
          return handler.resolve(res);
        } catch (e) {
          print(e.toString());
        }
      }
    }));
  }
  Future<Map<String, dynamic>> getTrending() async {
    try {
      Response response = await dio.get(
          "/top-headlines?country=us&apiKey=$apiKey");
      if (response.statusCode == 200 && response.data != null) {
        final TrendingModel trend = TrendingModel.fromJson(response.data);
        // final List<dynamic> articles = response.data['articles'];
        // print("s $articles");
        // print(trend.articles);

        return {
          "data": trend.articles,
          "sucesss": true,
        };
      } else {
        return {
          "data": "Data not found",
          "sucesss": false,
        };
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}

      // print("TrendingModel:");
      // print("Status: ${trend.status}");
      // print("Total Results: ${trend.totalResults}");
      // print("Articles:");
      // for (var article in trend.articles) {
      //   print("- Title: ${article.title}");
      //   print("  Author: ${article.author ?? 'N/A'}");
      //   print("  Published At: ${article.publishedAt}");
      //   print("  URL: ${article.url}");
      // }

      // final List<TrendingModel> trendingNews =
      //     articles.map((json) => TrendingModel.fromJson(json)).toList();