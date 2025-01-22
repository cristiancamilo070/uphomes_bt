// import 'package:get/get.dart';
// import 'package:object_detection/core/controllers/base_getx_controller.dart';
// import 'package:object_detection/domain/models/detected_object.dart';
// import 'package:object_detection/domain/use_cases/get_object_details_use_case.dart';

// class ObjectDetectionController extends BaseGetxController {
//   final GetObjectDetailsUseCase getObjectDetailsUseCase;

//   ObjectDetectionController(this.getObjectDetailsUseCase);

//   Rx<DetectedObject?> detectedObject = Rx(null);
//   RxBool isLoading = false.obs;

//   Future<void> detectAndFetchObject(String objectId) async {
//     showLoading('Detectando objeto...');
//     try {
//       final object = await getObjectDetailsUseCase(objectId);
//       detectedObject.value = object;
//       closeLoading();
//       showSuccess('Éxito', 'Objeto detectado y cargado.');
//     } catch (e) {
//       closeLoading();
//       showError('Error', 'No se pudo cargar el objeto.');
//     }
//   }
// }