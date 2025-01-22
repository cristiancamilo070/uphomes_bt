// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/themes/app_theme.dart';
import 'package:samay_test/core/themes/theme_controller.dart';
import 'package:samay_test/core/widgets/buttons/primary_button.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_text_form_field.dart';
import 'package:samay_test/core/widgets/inputs/utils/input_validator_utils.dart';
import 'package:samay_test/presentation/detail_project/controller/detail_project_controller.dart';

class EditProjectForm extends GetView<DetailProjectController> {
  const EditProjectForm({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildEditForm().paddingAll(16);
  }

  Widget _buildEditForm() {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => Form(
        key: controller.editFormKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Edit Project',
                      style: AppTheme.style.bold,
                    ),
                    const SizedBox(height: 16),
                    AppTextFormFieldWidget(
                      AppInputParameters(
                        hintText: 'Name'.tr,
                        showCancelIcon: false,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputType: AppInputType.text,
                        controller: controller.nameController,
                        labelText: 'Name'.tr,
                        isRequired: true,
                        requiredErrorMessage: 'This field is required'.tr,
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
                        hintText: 'Location'.tr,
                        showCancelIcon: false,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputType: AppInputType.text,
                        controller: controller.locationController,
                        labelText: 'Location'.tr,
                        isRequired: true,
                        requiredErrorMessage: 'This field is required'.tr,
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
                        hintText: 'Price'.tr,
                        showCancelIcon: false,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputType: AppInputType.number,
                        controller: controller.priceController,
                        labelText: 'Price'.tr,
                        isRequired: true,
                        requiredErrorMessage: 'This field is required'.tr,
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
                        hintText: 'Image URL'.tr,
                        showCancelIcon: false,
                        maxLines: 4,
                        textInputAction: TextInputAction.next,
                        inputType: AppInputType.text,
                        controller: controller.imageUrlController,
                        labelText: 'Image URL'.tr,
                        isRequired: true,
                        requiredErrorMessage: 'This field is required'.tr,
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
                        hintText: 'Description'.tr,
                        showCancelIcon: false,
                        maxLines: 5,
                        textInputAction: TextInputAction.next,
                        inputType: AppInputType.text,
                        controller: controller.descriptionController,
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
                        controller: controller.statusController,
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
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                onPressed: () async {
                  if (controller.editFormKey.currentState?.validate() ??
                      false) {
                    await controller.updateProject();
                  }
                },
                text: 'Save Changes'.tr,
                borderRadius: 16,
                style: AppTheme.style.bold.copyWith(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
