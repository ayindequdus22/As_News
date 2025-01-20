import 'dart:developer';

import 'package:as_news/utils/api_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ForYou extends StatefulWidget {
  const ForYou({super.key});

  @override
  State<ForYou> createState() => _ForYouState();
}

class _ForYouState extends State<ForYou> {
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
        log(trends[0]
            .author
            .toString()); // Access only if the list is not empty
      } else {
        log("No data available.");
      }
    }
    return Column(
      children: [
        // NewsCategories(category: "Entertainment"),
        Text("For you"),
        isLoading //if loading is true show animation
            ? Center(child: CircularProgressIndicator())
            : error.isNotEmpty // if error is true show error
                ? Center(child: Text(error))
                : trends.isEmpty //or if it's empty show no data available
                    ? Center(child: Text('No data available.')) // show data
                    : SizedBox(
                        height: 400.h,
                        child: CarouselView(
                          scrollDirection: Axis.horizontal,
                          itemExtent: 200.w,
                          children: [
                            ListView.builder(
                              itemCount: trends.length,
                              itemBuilder: (context, index) {
                                //     // final article = trends[index];
                                //     // return ListTile(
                                //     //   title: Text(article.title ?? 'No Title'),
                                //     //   subtitle:
                                //     //       Text(article.description ?? 'No Description'),

                                // );
                                return Column(
                                  children: [
  //                                   Image.network(loadingBuilder: (context, child, progress) {
  //   if (progress == null) return child;
  //   return CircularProgressIndicator();
  // },
  // errorBuilder: (context, error, stackTrace) {
  //   print("Error: $error"); // Log the error
  //   return Icon(Icons.broken_image); // Show fallback UI
  // },
  //                                       trends[index].urlToImage.toString(),)
                            CachedNetworkImage(
  imageUrl: "https://example.com/news-image.jpg",
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
      ],
    );
  }
}
