// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/controllers/base_getx_controller.dart';
import 'package:samay_test/domain/models/agency_model.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/domain/use_cases/agency_use_cases/get_all_agencies_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/create_project_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/get_all_projects_use_case.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomeController extends BaseGetxController {
  final GetAllAgenciesUseCase getAllAgenciesUseCase = Get.find();
  final GetAllProjectsUseCase getAllProjectsUseCase = Get.find();
  final CreateProjectUseCase createProjectUseCase = Get.find();

  TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> addFormKey = GlobalKey<FormState>();

  RxList<AgencyModel> agencies = <AgencyModel>[].obs;
  RxList<ProjectModel> projects = <ProjectModel>[].obs;
  RxList<ProjectModel> filteredProjects = <ProjectModel>[].obs;

  RxBool isLoading = true.obs;
  RxString searchQuery = ''.obs;
  RxList<int> selectedAgencyIds = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAgencies();
    fetchProjects();
  }

  void fetchAgencies() async {
    isLoading.value = true;
    final result = await getAllAgenciesUseCase.execute();
    result.fold(
      (exception) {
        print("Error fetching agencies: $exception");
        isLoading.value = false;
      },
      (data) {
        agencies.value = data;
        isLoading.value = false;
      },
    );
  }

  void fetchProjects() async {
    isLoading.value = true;
    final result = await getAllProjectsUseCase.execute();
    result.fold(
      (exception) {
        print("Error fetching projects: $exception");
        isLoading.value = false;
      },
      (data) {
        projects.value = data;
        filterProjects();
        isLoading.value = false;
      },
    );
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
    filterProjects();
  }

  void onAgencyFilterChanged(List<int> selectedIds) {
    selectedAgencyIds.value = selectedIds;
    filterProjects();
  }

  void filterProjects() {
    final query = searchQuery.value.toLowerCase();
    final selectedIds = selectedAgencyIds;

    filteredProjects.value = projects.where((project) {
      final matchesSearch = project.name.toLowerCase().contains(query);
      final matchesAgency =
          selectedIds.isEmpty || selectedIds.contains(project.agencyId);

      return matchesSearch && matchesAgency;
    }).toList();
  }

  Future<void> addProject(ProjectModel newProject) async {
    showLoading();
    final result =
        await createProjectUseCase.execute(CreateProjectParams(newProject));
    result.fold(
      (exception) {
        closeLoading();
        showErrorMessage(
            'Error', 'Failed to add project: ${exception.message}');
      },
      (_) {
        closeLoading();
        Get.back();
        showSuccessMessage('Success', 'Project added successfully');
        fetchProjects();
      },
    );
  }

  // Future<void> exportDatabase() async {
  //   try {
  //     final sourcePath = await getDatabasesPath();
  //     final sourceFile = join(sourcePath, 'database.db');

  //     if (!File(sourceFile).existsSync()) {
  //       throw FileSystemException(
  //           'El archivo de base de datos fuente no existe', sourceFile);
  //     }
  //     const destinationPath = '/Users/cristiancruz/Documents/database12345.db';

  //     final file = File(sourceFile);
  //     await file.copy(destinationPath);

  //     print('Base de datos exportada exitosamente a $destinationPath');
  //   } catch (e) {
  //     print('Error exportando la base de datos: $e');
  //   }
  // }
}
