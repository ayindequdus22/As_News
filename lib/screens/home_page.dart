import 'package:as_news/utils/api_provider.dart';
import 'package:as_news/widgets/for_you.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //  late Future<Map<String, dynamic>> trendingArticles;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static List<Tab> tabs = [
    myTabs("For you"),
    myTabs("Entertainment"),
    myTabs("Technology"),
    myTabs("Health"),
    myTabs("Education"),
    myTabs("Business"),
    myTabs("World"),
    myTabs("Travel")
  ];

  static Tab myTabs(String text) {
    return Tab(
      child: Text(
        text,
        style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final trends = context.watch<ApiProvider>().trendingNews;
    // final isLoading = context.watch<ApiProvider>().isLoading;
    // final error = context.watch<ApiProvider>().error;
    // if (!isLoading) {
    //   if (trends.isNotEmpty) {
    //     print(trends[0].author); // Access only if the list is not empty
    //   } else {
    //     print("No data available.");
    //   }
    // }
    // if (!isLoading) {
    //   print(trends[0].author);
    // }
    // print(trends[0].articles);
    // print(trendingArticles);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverPadding(
              padding: EdgeInsets.all(0),
              sliver: SliverAppBar(
                pinned: true,
                floating: true,
                leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                title: Text("AsNews"),
                centerTitle: true,
                actions: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
                ],
                bottom: TabBar(
                  isScrollable: true,
                  controller: _tabController,
                  tabs: tabs,
                ),
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            ForYou(),
            NewsCategories(category: "Entertainment"),
            NewsCategories(category: "Technology"),
            NewsCategories(category: "Health"),
            NewsCategories(category: "Education"),
            NewsCategories(category: "Business"),
            NewsCategories(category: "World"),
            NewsCategories(category: "Travel")
          ],
        ),
      ),
    );
  }
}

class NewsCategories extends StatelessWidget {
  const NewsCategories({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            child: Text("Click"),
            onTap: () {
              // DioRequestServices().getTrending();
              context.read<ApiProvider>().getTrending();
            },
          ),
          Text(category),
        ],
      ),
    );
  }
}
