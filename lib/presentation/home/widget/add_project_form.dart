// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/themes/app_theme.dart';
import 'package:samay_test/core/themes/theme_controller.dart';
import 'package:samay_test/core/widgets/buttons/primary_button.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_text_form_field.dart';
import 'package:samay_test/core/widgets/inputs/utils/input_validator_utils.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/presentation/home/controllers/home_controller.dart';

class AddProjectForm extends GetView<HomeController> {
  const AddProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildAddForm().paddingAll(16);
  }

  Widget _buildAddForm() {
    final themeController = Get.find<ThemeController>();

    final TextEditingController nameController = TextEditingController();
    final TextEditingController locationController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController statusController = TextEditingController();

    final RxInt selectedAgencyId = RxInt(0);

    return Obx(() => Form(
          key: controller.addFormKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Project',
                        style: AppTheme.style.bold,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        value: selectedAgencyId.value == 0
                            ? null
                            : selectedAgencyId.value,
                        items: controller.agencies
                            .map((agency) => DropdownMenuItem<int>(
                                  value: agency.id,
                                  child: Text(agency.name),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            selectedAgencyId.value = value;
                          }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Agency',
                          hintStyle: AppTheme.style.regular.copyWith(
                            color: themeController.primaryColor.value
                                .withOpacity(0.7),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: themeController.primaryColor.value
                                  .withOpacity(0.7),
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: themeController.primaryColor.value
                                  .withOpacity(0.7),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: themeController.primaryColor.value,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                      heightSpace8,
                      AppTextFormFieldWidget(
                        AppInputParameters(
                          hintText: 'Name'.tr,
                          showCancelIcon: false,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          inputType: AppInputType.text,
                          controller: nameController,
                          labelText: 'Name'.tr,
                          isRequired: true,
                          requiredErrorMessage: 'This field is required'.tr,
                          autoDisposeController: false,
                          customValidator: InputValidatorUtils.validate,
                          context: Get.context!,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: themeController.primaryColor.value,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value
                                    .withOpacity(0.7),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      heightSpace8,
                      AppTextFormFieldWidget(
                        AppInputParameters(
                          hintText: 'Location'.tr,
                          showCancelIcon: false,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          inputType: AppInputType.text,
                          controller: locationController,
                          labelText: 'Location'.tr,
                          isRequired: true,
                          requiredErrorMessage: 'This field is required'.tr,
                          autoDisposeController: false,
                          customValidator: InputValidatorUtils.validate,
                          context: Get.context!,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: themeController.primaryColor.value,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value
                                    .withOpacity(0.7),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      heightSpace8,
                      AppTextFormFieldWidget(
                        AppInputParameters(
                          hintText: 'Price'.tr,
                          showCancelIcon: false,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          inputType: AppInputType.number,
                          controller: priceController,
                          labelText: 'Price'.tr,
                          isRequired: true,
                          requiredErrorMessage: 'This field is required'.tr,
                          autoDisposeController: false,
                          customValidator: InputValidatorUtils.validate,
                          context: Get.context!,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: themeController.primaryColor.value,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value
                                    .withOpacity(0.7),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      heightSpace8,
                      AppTextFormFieldWidget(
                        AppInputParameters(
                          hintText: 'Image URL'.tr,
                          showCancelIcon: false,
                          maxLines: 4,
                          textInputAction: TextInputAction.next,
                          inputType: AppInputType.text,
                          controller: imageUrlController,
                          labelText: 'Image URL'.tr,
                          isRequired: true,
                          requiredErrorMessage: 'This field is required'.tr,
                          autoDisposeController: false,
                          customValidator: InputValidatorUtils.validate,
                          context: Get.context!,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                              color: themeController.primaryColor.value,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value
                                    .withOpacity(0.7),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      heightSpace8,
                      AppTextFormFieldWidget(
                        AppInputParameters(
                          hintText: 'Description'.tr,
                          showCancelIcon: false,
                          maxLines: 5,
                          textInputAction: TextInputAction.next,
                          inputType: AppInputType.text,
                          controller: descriptionController,
                          labelText: 'Description'.tr,
                          isRequired: false,
                          autoDisposeController: false,
                          customValidator: InputValidatorUtils.validate,
                          context: Get.context!,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: themeController.primaryColor.value),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value
                                    .withOpacity(0.7),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      heightSpace8,
                      AppTextFormFieldWidget(
                        AppInputParameters(
                          hintText: 'Status'.tr,
                          showCancelIcon: false,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          inputType: AppInputType.text,
                          controller: statusController,
                          labelText: 'Status'.tr,
                          isRequired: false,
                          autoDisposeController: false,
                          customValidator: InputValidatorUtils.validate,
                          context: Get.context!,
                          decoration: InputDecoration(
                            labelStyle: TextStyle(
                                color: themeController.primaryColor.value),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value,
                                width: 2,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                color: themeController.primaryColor.value
                                    .withOpacity(0.7),
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      heightSpace16,
                      heightSpace16,
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  onPressed: () async {
                    final newProject = ProjectModel(
                      id: 0,
                      agencyId: selectedAgencyId.value,
                      name: nameController.text,
                      location: locationController.text,
                      price: int.tryParse(priceController.text) ?? 0,
                      imageUrl: imageUrlController.text,
                      description: descriptionController.text,
                      status: statusController.text,
                    );

                    if (controller.addFormKey.currentState?.validate() ??
                        false) {
                      await controller.addProject(newProject);
                    }
                  },
                  text: 'Add Project'.tr,
                  style: AppTheme.style.bold,
                ),
              ),
            ],
          ),
        ));
  }
}
