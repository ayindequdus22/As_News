import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:as_news/utils/api_provider.dart';
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // NewsCategories(category: "Entertainment"),
        Text("For you"),
        isLoading //if loading is true show animation
            ? Center(child: CircularProgressIndicator())
            : error.isNotEmpty // if error is true show error
                ? Center(child: Text(error))
                : trends.isEmpty //or if it's empty show no data available
                    ? Center(child: Text('No data available.')) // show data
                    : CarouselSlider(
                        // scrollDirection: Axis.horizontal,
                        // itemExtent: ScreenUtil().screenHeight,
                        options: CarouselOptions(
                          height: 400.h,
                          pageSnapping: true,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                        ),
                        items: trends.map((trend) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                clipBehavior: Clip.hardEdge,
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                // width: ScreenUtil().screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r)),
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: trend.urlToImage.toString(),
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                    Text(trend.title.toString()),
                                    Text(trend.content.toString()),
                                    Text(trend.source!.name.toString())
                                  ],
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
      ],
    );
  }
}
