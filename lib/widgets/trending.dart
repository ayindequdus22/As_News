import 'package:as_news/utils/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ApiProvider>().getTrending();
    });
  }

  @override
  Widget build(BuildContext context) {
    final trends = context.watch<ApiProvider>().trendingNews;
    final isLoading = context.watch<ApiProvider>().isLoading;
    final error = context.watch<ApiProvider>().error;
 if (!isLoading) {
      if (trends.isNotEmpty) {
        print(trends[0].author); // Access only if the list is not empty
      } else {
        print("No data available.");
      }
    }
    return Column(
      children: [
        // NewsCategories(category: "Entertainment"),
        isLoading //if loading is true show animation
            ? Center(child: CircularProgressIndicator())
            : error.isNotEmpty // if error is true show error
                ? Center(child: Text(error))
                : trends.isEmpty //or if it's empty show no data available
                    ? Center(child: Text('No data available.')) // show data
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemCount: trends.length,
                          itemBuilder: (context, index) {
                            final article = trends[index];
                            return ListTile(
                              title: Text(article.title ?? 'No Title'),
                              subtitle:
                                  Text(article.description ?? 'No Description'),
                            );
                          },
                        ),
                      ),
      ],
    );
  }
}
