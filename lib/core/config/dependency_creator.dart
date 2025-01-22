import 'package:get/get.dart';
import 'package:samay_test/core/controllers/main_controller.dart';
import 'package:samay_test/core/localization/repositories/localization_repository.dart';
import 'package:samay_test/core/themes/theme_controller.dart';
import 'package:samay_test/data/providers/database_provider.dart';
import 'package:samay_test/data/repositories/agency_repository_impl.dart';
import 'package:samay_test/data/repositories/project_repository_impl.dart';
import 'package:samay_test/data/repositories/security/secure_storage_repository_impl.dart';
import 'package:samay_test/data/repositories/security/shared_preference_repository_impl.dart';
import 'package:samay_test/domain/repositories/agency_repository.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/repositories/security/secure_storage_repository.dart';
import 'package:samay_test/domain/repositories/security/shared_preference_repository.dart';

class DependencyCreator {
  static initialize() {
    Get.put(DatabaseProvider(), permanent: true);

    Get.put(LocalizationRepository(), permanent: true);

    Get.put<AgencyRepository>(
      AgencyRepositoryImpl(Get.find<DatabaseProvider>()),
      permanent: true,
    );

    Get.put<ProjectRepository>(
      ProjectRepositoryImpl(Get.find<DatabaseProvider>()),
      permanent: true,
    );

    Get.put<SecureStorageRepository>(
      SecureStorageRepositoryImpl(),
      permanent: true,
    );

    Get.put<SharedPreferencesRepository>(
      SharedPreferencesRepositoryImpl(),
      permanent: true,
    );

    Get.put(
      MainController(),
      permanent: true,
    );

    Get.put(
      ThemeController(),
      permanent: true,
    );
  }
}
