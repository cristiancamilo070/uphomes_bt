import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/controllers/base_getx_controller.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/delete_project_use_case.dart';
import 'package:samay_test/domain/use_cases/project_use_cases/update_project_use_case.dart';
import 'package:samay_test/presentation/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProjectController extends BaseGetxController {
  final UpdateProjectUseCase updateProjectUseCase = Get.find();
  final DeleteProjectUseCase deleteProjectUseCase = Get.find();

  late ProjectModel project;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  final GlobalKey<FormState> editFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    project = Get.arguments as ProjectModel;
    initializeFields();
  }

  void initializeFields() {
    nameController.text = project.name;
    locationController.text = project.location;
    priceController.text = project.price.toString();
    imageUrlController.text = project.imageUrl ?? '';
    descriptionController.text = project.description ?? '';
    statusController.text = project.status ?? '';
  }

  Future<void> updateProject() async {
    final updatedProject = ProjectModel(
      id: project.id,
      agencyId: project.agencyId,
      name: nameController.text,
      location: locationController.text,
      price: int.tryParse(priceController.text) ?? project.price,
      imageUrl: imageUrlController.text,
      description: descriptionController.text,
      status: statusController.text,
    );
    showLoading();
    final result =
        await updateProjectUseCase.execute(UpdateProjectParams(updatedProject));

    result.fold(
      (exception) {
        closeLoading();
        showErrorMessage(
            'Error', 'Failed to update project: ${exception.message}');
      },
      (_) {
        closeLoading();
        Get.back();
        Get.back(result: updatedProject);
        showSuccessMessage('Success', 'Project updated successfully');
      },
    );
  }

  Future<void> deleteProject() async {
    showLoading();
    final result =
        await deleteProjectUseCase.execute(DeleteProjectParams(project.id));

    result.fold(
      (exception) {
        closeLoading();
        showErrorMessage(
            'Error', 'Failed to Delete project: ${exception.message}');
      },
      (_) {
        closeLoading();
        Get.find<HomeController>().fetchProjects();
        Get.back();
        showSuccessMessage('Success', 'Project deleted successfully');
      },
    );
  }

  void contactViaEmail() async {
    const email = 'example@example.com';
    final subject = Uri.encodeComponent('Consulta sobre ${project.name}');
    final body = Uri.encodeComponent(
      'Hola,\n\nEstoy interesado en el proyecto ${project.name} ubicado en ${project.location}.\n'
      'Por favor contácteme para más detalles.\n\nGracias.',
    );
    final emailUri = Uri.parse('mailto:$email?subject=$subject&body=$body');

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      showErrorMessage('Error',
          'No se pudo abrir el cliente de correo, asegurate de tener un app de correo .');
    }
  }
}
