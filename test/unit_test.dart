// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:samay_test/presentation/home/controllers/home_controller.dart';

void main() {
  group('HomeController Test', () {
    late HomeController controller;

    setUp(() {
      controller = Get.put(HomeController());
    });

    tearDown(() {
      Get.delete<HomeController>();
    });
  });
}
