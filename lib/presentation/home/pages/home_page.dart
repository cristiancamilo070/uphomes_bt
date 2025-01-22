// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/themes/app_theme.dart';
import 'package:samay_test/core/themes/theme_controller.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_input_parameters.dart';
import 'package:samay_test/core/widgets/inputs/src/text_field/app_text_form_field.dart';
import 'package:samay_test/core/widgets/inputs/utils/input_validator_utils.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/presentation/detail_project/controller/detail_project_binding.dart';
import 'package:samay_test/presentation/detail_project/pages/detail_project_page.dart';
import 'package:samay_test/presentation/home/controllers/home_controller.dart';
import 'package:samay_test/presentation/home/widget/add_project_form.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _headerWidgets(context)),
          SliverToBoxAdapter(
            child: _buildProjectList(context),
          ),
        ],
      ),
    );
  }

  Widget _headerWidgets(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://th.bing.com/th/id/R.70f5ae4b6240a91bfe7eae1d873de219?rik=2rRmLy0df1Nwmw&pid=ImgRaw&r=0', // Replace with your image URL
          height: 370,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
            color: AppTheme.colors.appPrimary,
          )),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace16,
                  _buildFilterDropdown(),
                  _welcomeWidget(context),
                  _buildSearchBar(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _welcomeWidget(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () {
        return Container(
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.house,
                    color: themeController.primaryColor.value,
                    size: 40,
                  ),
                  heightSpace8,
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Up',
                          style: AppTheme.style.bold.copyWith(
                            fontSize: 33,
                            color: AppTheme.colors.appQuaternary,
                          ),
                        ),
                        TextSpan(
                          text: 'Homes',
                          style: AppTheme.style.regular.copyWith(
                            fontSize: 33,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              heightSpace8,
              Text(
                'Welcome!',
                style: AppTheme.style.bold.copyWith(
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              heightSpace8,
              Text(
                'Find your Dream Space',
                style: AppTheme.style.regular.copyWith(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterDropdown() {
    final themeController = Get.find<ThemeController>();
    return Obx(() {
      final agencies = controller.agencies;

      return Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<int>(
              isExpanded: true,
              value: controller.selectedAgencyIds.isEmpty
                  ? null
                  : controller.selectedAgencyIds.first,
              items: agencies
                  .map((agency) => DropdownMenuItem<int>(
                        value: agency.id,
                        child: Text(
                          agency.name,
                          style: AppTheme.style.regular.copyWith(
                            color: AppTheme.colors.appBlack,
                          ),
                        ),
                      ))
                  .toList(),
              onChanged: (selectedId) {
                if (selectedId != null) {
                  final selectedAgency =
                      agencies.firstWhere((agency) => agency.id == selectedId);
                  themeController.updateTheme(selectedAgency);
                  controller.onAgencyFilterChanged([selectedId]);
                }
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Agency',
                hintStyle: AppTheme.style.regular.copyWith(
                  color: themeController.primaryColor.value.withOpacity(0.7),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: themeController.primaryColor.value.withOpacity(0.7),
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: themeController.primaryColor.value.withOpacity(0.7),
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
          ),
          if (controller.selectedAgencyIds.isNotEmpty)
            GestureDetector(
              child: FaIcon(
                FontAwesomeIcons.solidCircleXmark,
                color: themeController.primaryColor.value,
                size: 30,
              ).paddingOnly(left: 16),
              onTap: () {
                controller.onAgencyFilterChanged([]);

                themeController.updateTheme(null);
              },
            ),
        ],
      ).paddingSymmetric(horizontal: 16);
    });
  }

  Widget _buildSearchBar() {
    final themeController = Get.find<ThemeController>();

    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: AppTextFormFieldWidget(
          AppInputParameters(
            hintText: 'Medellín'.tr,
            showCancelIcon: false,
            maxLines: 1,
            textInputAction: TextInputAction.next,
            inputType: AppInputType.alphabet,
            controller: controller.searchController,
            labelText: 'Address, name, price...'.tr,
            isRequired: false,
            autoDisposeController: false,
            customValidator: InputValidatorUtils.validate,
            context: Get.context!,
            onChanged: controller.onSearchChanged,
            decoration: InputDecoration(
              labelStyle: TextStyle(color: themeController.primaryColor.value),
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
                  color: themeController.primaryColor.value.withOpacity(0.7),
                  width: 1,
                ),
              ),
            ),
          ),
        ).paddingSymmetric(horizontal: 16),
      );
    });
  }

  Widget _buildProjectList(BuildContext context) {
    return Obx(() {
      final themeController = Get.find<ThemeController>();

      if (controller.isLoading.value) {
        return Center(
            child: CircularProgressIndicator(
          color: AppTheme.colors.appPrimary,
        ));
      }

      final projects = controller.filteredProjects;

      if (projects.isEmpty) {
        return Center(
          child: const Text('No projects found').paddingSymmetric(vertical: 50),
        );
      }

      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Add project...',
                style: AppTheme.style.regular,
              ),
              widthSpace10,
              GestureDetector(
                onTap: () => _showAddProjectBottomSheet(context),
                //onTap: () => controller.exportDatabase(),
                child: FaIcon(
                  FontAwesomeIcons.solidSquarePlus,
                  size: 40,
                  color: themeController.primaryColor.value,
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 8),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return _buildProjectCard(project);
            },
          ),
        ],
      );
    });
  }

  Widget _buildProjectCard(ProjectModel project) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => const DetailProjectPage(),
          arguments: project,
          binding: DetailProjectBinding(),
          transition: Transition.topLevel,
          duration: const Duration(milliseconds: 500),
        )?.then((updatedProject) {
          if (updatedProject != null) {
            controller.fetchProjects();
          }
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Hero(
                tag: 'image_${project.id}',
                transitionOnUserGestures: true,
                child: CachedNetworkImage(
                  imageUrl: project.imageUrl ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                    color: AppTheme.colors.appPrimary,
                  )),
                  errorWidget: (context, url, error) =>
                      const Center(child: Icon(Icons.error)),
                ),
              ),
            ),
            // Text section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: AppTheme.style.bold.copyWith(fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.location,
                    style: AppTheme.style.regular.copyWith(
                      fontSize: 14,
                      color: AppTheme.colors.appBlackGrey.withOpacity(0.8),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProjectBottomSheet(BuildContext context) {
    const borderRadius = BorderRadius.vertical(top: Radius.circular(24.0));

    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.8,
        child: const AddProjectForm(),
      ),
      elevation: 24,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    );
  }
}
