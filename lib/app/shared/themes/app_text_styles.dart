import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/shared/themes/app_colors.dart';

class AppTextStyles {
  static TextStyle display = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static TextStyle headline = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleMedium = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 16.0,
  );

  static TextStyle bodyText1 = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 12.0,
  );

  static TextStyle bodyText2 = TextStyle(
    color: AppColors.primaryBlue,
    fontSize: 10.0,
  );
}
