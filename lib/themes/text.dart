import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextTheme {
  const AppTextTheme._();

  static TextTheme buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      headlineLarge: const TextStyle().copyWith(
          fontSize: 36.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface),
      headlineMedium: const TextStyle().copyWith(
          fontSize: 32.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface),
      headlineSmall: const TextStyle().copyWith(
          fontSize: 28.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface),
      titleLarge: const TextStyle().copyWith(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface),
      titleMedium: const TextStyle().copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface),
      titleSmall: const TextStyle().copyWith(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurface),
      bodyLarge: const TextStyle().copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
          color: colorScheme.onSurface),
      bodyMedium: const TextStyle().copyWith(
        fontSize: 16.sp,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: const TextStyle().copyWith(
        fontSize: 14.sp,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: const TextStyle().copyWith(
        fontSize: 12.sp,
        color: colorScheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
