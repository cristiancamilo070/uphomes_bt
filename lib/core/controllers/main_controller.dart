import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:samay_test/core/controllers/base_getx_controller.dart';

class MainController extends BaseGetxController {
  final RxString _appVersion = "".obs;

  final RxBool isReadyDependencies = false.obs;

  MainController();

  @override
  void onInit() {
    super.onInit();

    _initDependencies();
  }

  String get versionApp {
    return "${'VERSION'.tr.toUpperCase()} ${_appVersion.value}";
  }

  Future<void> _initDependencies() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    _appVersion(packageInfo.version);

    await Future.wait([]);

    isReadyDependencies(true);
  }
}
