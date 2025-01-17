import 'package:as_news/models/trending_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import "package:dio"
// import 'dart:convert';

// import 'package:as_news/models/trending_model.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
//

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

// //   Future<List<Post>> fetchPosts() async {
// //   final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

// //   try {
// //     final response = await http.get(url);

// //     if (response.statusCode == 200) {
// //       final List<dynamic> data = json.decode(response.body);
// //       return data.map((post) => Post.fromJson(post)).toList();
// //     } else {
// //       throw Exception('Failed to load posts. Status code: ${response.statusCode}');
// //     }
// //   } catch (e) {
// //     throw Exception('Error occurred: $e');
// //   }
// // }
// }

class DioRequestServices {
  static final apiKey = dotenv.env['NEWS_API_KEY'];
  Future<Map<String, dynamic>> getTrending() async {
    try {
      Response response = await Dio().get(
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey");
      if (response.statusCode == 200 && response.data != null) {
        final TrendingModel trend = TrendingModel.fromJson(response.data);
        final List<dynamic> articles = response.data['articles'];
        print("s $articles");
      

        return {
          "data": "Not yet",
          "sucesss": true,
        };
      } else {
        return {
          "data": "Data not found",
          "sucesss": false,
        };
      }
    } catch (e) {
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