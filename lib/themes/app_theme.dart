import 'package:as_news/themes/color_scheme.dart';
import 'package:as_news/themes/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  const AppTheme();
  static ThemeData _buildTheme(
      ColorScheme colorScheme, BuildContext context, TextTheme textTheme) {
    // final themeContext = Theme.of(context);

    return ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: textTheme,
        scaffoldBackgroundColor: colorScheme.surface,
        tabBarTheme: TabBarTheme(
          tabAlignment: TabAlignment.start,
          labelPadding: EdgeInsets.symmetric(horizontal: 12.0.w),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                minimumSize:
                    WidgetStatePropertyAll(Size(double.infinity, 60.h)),
                splashFactory: InkSparkle.splashFactory,
                textStyle: WidgetStatePropertyAll(
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
                backgroundColor: WidgetStatePropertyAll(colorScheme.primary),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                )))));
  }

  static ThemeData lightMode(BuildContext context) {
    return _buildTheme(MyColorScheme.lightColorScheme, context,
        AppTextTheme.buildTextTheme(MyColorScheme.lightColorScheme));
  }

  static ThemeData darkMode(BuildContext context) {
    return _buildTheme(MyColorScheme.darkColorScheme, context,
        AppTextTheme.buildTextTheme(MyColorScheme.darkColorScheme));
  }
}
