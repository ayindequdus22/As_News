import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      //   title: Text("AsNews"),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
      //   ],
      //   bottom: TabBar(
      //     controller: _tabController,
      //     padding: EdgeInsets.only(left: 20.sp),
      //     labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
      //     tabs: tabs,
      //     isScrollable: true,
      //   ),
      // ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              leading: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              title: Text("AsNews"),
              centerTitle: true,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
              ],
              bottom: TabBar(
                controller: _tabController,
                padding: EdgeInsets.only(left: 20.sp),
                labelPadding: EdgeInsets.symmetric(horizontal: 12.0),
                tabs: tabs,
                isScrollable: true,
              ),
            )
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            NewsCategories(category: "For you"),
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
      child: Text(category),
    );
  }
}
