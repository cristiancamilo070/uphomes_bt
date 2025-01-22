import 'package:get/get.dart';
import 'package:samay_test/domain/repositories/agency_repository.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/use_cases/agency_use_cases/create_agency_use_case.dart';
import 'package:samay_test/domain/use_cases/agency_use_cases/delete_agency_use_case.dart';
import 'package:samay_test/domain/use_cases/agency_use_cases/get_all_agencies_use_case.dart';
import 'package:samay_test/domain/use_cases/agency_use_cases/update_agency_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/create_project_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/delete_project_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/get_all_projects_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/get_project_by_agency_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/update_project_use_case.dart';
import 'package:samay_test/presentation/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    //Agencies
    Get.lazyPut(
      () => GetAllAgenciesUseCase(Get.find<AgencyRepository>()),
    );
    Get.lazyPut(
      () => CreateAgencyUseCase(Get.find<AgencyRepository>()),
    );
    Get.lazyPut(
      () => UpdateAgencyUseCase(Get.find<AgencyRepository>()),
    );
    Get.lazyPut(
      () => DeleteAgencyUseCase(Get.find<AgencyRepository>()),
    );
    //Projects
    Get.lazyPut(
      () => GetAllProjectsUseCase(Get.find<ProjectRepository>()),
    );
    Get.lazyPut(
      () => CreateProjectUseCase(Get.find<ProjectRepository>()),
    );
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
