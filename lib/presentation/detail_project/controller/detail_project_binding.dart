import 'package:get/get.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/delete_project_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/get_project_by_agency_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/update_project_use_case.dart';
import 'package:samay_test/presentation/detail_project/controller/detail_project_controller.dart';

class DetailProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailProjectController());

    //Projects

    Get.lazyPut(
      () => DeleteProjectUseCase(Get.find<ProjectRepository>()),
    );
    Get.lazyPut(
      () => UpdateProjectUseCase(Get.find<ProjectRepository>()),
    );
    Get.lazyPut(
      () => GetProjectsByAgencyIdUseCase(Get.find<ProjectRepository>()),
    );
  }
}
