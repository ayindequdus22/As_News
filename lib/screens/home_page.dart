import 'package:as_news/utils/api_provider.dart';
import 'package:as_news/utils/services/api_services.dart';
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
    final trends = context.watch<ApiProvider>().trendingNews;
    print(trends[0].articles);
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
            NewsCategories(category: "For you"),
            Column(
              children: [
                NewsCategories(category: "Entertainment"),
              ],
            ),
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
              context.read<ApiProvider>().getTrending();
            },
          ),
          Text(category),
        ],
      ),
    );
  }
}
