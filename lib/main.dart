import 'package:as_news/screens/not_found.dart';
import 'package:as_news/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:as_news/utils/api_provider.dart';
import 'package:as_news/screens/home_page.dart';
import 'package:as_news/themes/app_theme.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await ScreenUtil.ensureScreenSize();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ApiProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.darkMode(context),
            onGenerateRoute: (RouteSettings e) {
              switch (e.name) {
                case "/":
                  return getPage(widget: WelcomeScreen());
                case "/home":
                  return getPage(widget: HomePage());
                default:
                  return getPage(widget: NotFound());
              }
            },
          );
        });
  }

  GetPageRoute<dynamic> getPage({required Widget widget}) {
    return GetPageRoute(
        page: () => widget,
        transition: Transition.cupertino,
        showCupertinoParallax: true,
        transitionDuration: const Duration(
          seconds: 2,
        ));
  }
}
