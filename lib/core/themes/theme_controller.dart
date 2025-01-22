import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/themes/app_theme.dart';
import 'package:samay_test/domain/models/agency_model.dart';

class ThemeController extends GetxController {
  Rx<Color> primaryColor = AppColors().appPrimary.obs;
  Rx<Color> secondaryColor = AppColors().appSecondary.obs;

  void updateTheme(AgencyModel? agency) {
    Color newPrimaryColor = agency == null
        ? AppTheme.colors.appSecondary
        : Color(int.parse(agency.themeColor.replaceFirst('#', '0xFF')));
    primaryColor.value = newPrimaryColor;

    AppColors().updatePrimaryColor(newPrimaryColor);
  }
}
