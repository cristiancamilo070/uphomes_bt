// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:samay_test/core/themes/app_theme.dart';
import 'package:samay_test/core/widgets/buttons/primary_button.dart';
import 'package:samay_test/presentation/detail_project/controller/blue_controller.dart';
import 'package:samay_test/presentation/detail_project/controller/detail_project_controller.dart';
import 'package:samay_test/presentation/detail_project/widget/edit_project_form.dart';

class DetailProjectPage extends GetView<DetailProjectController> {
  const DetailProjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  heightSpace16,
                  _headerWidgets(context),
                  heightSpace16,
                  _bodyWidgets(context),
                  heightSpace16,
                  _bluetoothSection(context),
                  // BluetoothSectionWithBloc(),
                  heightSpace100,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: _fixedPriceBottom(),
          ),
        ],
      ),
    );
  }

  Widget _headerWidgets(BuildContext context) {
    return SafeArea(
      child: Hero(
        tag: 'image_${controller.project.id}',
        transitionOnUserGestures: true,
        child: Stack(
          children: [
            Material(
              elevation: 8,
              shadowColor: AppTheme.colors.appPrimary,
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: (controller.project.imageUrl == null ||
                      controller.project.imageUrl == '')
                  ? Container(
                      width: double.maxFinite,
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Text(
                          'No valid image'.tr,
                          style: AppTheme.style.regular,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: controller.project.imageUrl!,
                        // height: 320,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Container(
                          width: double.maxFinite,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppTheme.colors.appPrimary,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: double.maxFinite,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Text(
                              'No valid image'.tr,
                              style: AppTheme.style.regular,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            Positioned(
              top: 16,
              left: 16,
              child: _actionButton(
                icon: FontAwesomeIcons.arrowLeft,
                backgroundColor: AppTheme.colors.appBlack.withOpacity(0.5),
                onPressed: Get.back,
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: _actionButton(
                icon: FontAwesomeIcons.pen,
                backgroundColor: AppTheme.colors.appPrimary.withOpacity(0.7),
                onPressed: () => _showEditBottomSheet(context),
              ),
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: _actionButton(
                icon: FontAwesomeIcons.trash,
                backgroundColor: AppTheme.colors.appAlert.withOpacity(0.7),
                onPressed: () => controller.deleteProject(),
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyWidgets(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.project.name,
          style: AppTheme.style.bold.copyWith(fontSize: 20),
        ),
        heightSpace8,
        Text(
          controller.project.location,
          style: AppTheme.style.regular.copyWith(
            color: AppTheme.colors.appBlackGrey.withOpacity(0.7),
          ),
        ),
        heightSpace8,
        if (controller.project.description != null)
          Text(
            'Description',
            style: AppTheme.style.bold.copyWith(fontSize: 16),
          ),
        if (controller.project.description != null) heightSpace4,
        if (controller.project.description != null)
          Text(
            controller.project.description!,
            style: AppTheme.style.regular.copyWith(
              color: AppTheme.colors.appBlackGrey.withOpacity(0.7),
            ),
          ),
        heightSpace16,
        if (controller.project.status != null)
          Text(
            'Status',
            style: AppTheme.style.bold.copyWith(fontSize: 16),
          ),
        if (controller.project.status != null) heightSpace4,
        if (controller.project.status != null)
          Text(
            controller.project.status!,
            style: AppTheme.style.regular.copyWith(
              color: AppTheme.colors.appBlackGrey.withOpacity(0.7),
            ),
          ),
      ],
    ).paddingOnly(
      left: 16,
      right: 16,
      bottom: 16,
    );
  }

  Widget _fixedPriceBottom() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: AppTheme.colors.appBlack.withOpacity(0.8),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.colors.appBlack.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        right: 16,
        left: 16,
        bottom: 32,
        top: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${NumberFormat.currency(locale: 'es_CO', symbol: '', decimalDigits: 0).format(controller.project.price)} + taxes/fees',
            style: AppTheme.style.w700.copyWith(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
          PrimaryButton(
            onPressed: () => controller.contactViaEmail(),
            text: 'Contact',
            borderRadius: 16,
            style: AppTheme.style.bold.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    const borderRadius = BorderRadius.vertical(top: Radius.circular(24.0));

    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.8,
        child: const EditProjectForm(),
      ),
      elevation: 24,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: borderRadius),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return Material(
      elevation: 8,
      shadowColor: backgroundColor.withOpacity(0.5),
      color: Colors.transparent,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: backgroundColor,
          ),
          child: FaIcon(
            icon,
            color: iconColor ?? AppTheme.colors.white,
          ).paddingSymmetric(horizontal: 10, vertical: 8),
        ),
      ),
    );
  }

  Widget _bluetoothSection(BuildContext context) {
    final BluetoothController bluetoothController =
        Get.put(BluetoothController());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return _commandButtons(bluetoothController);
        }),
        // Sección de dispositivos reales
        Text(
          'Bluetooth Devices'.tr,
          style: AppTheme.style.bold.copyWith(fontSize: 20),
        ).paddingOnly(top: 16, left: 16, right: 16),

        Obx(() {
          if (bluetoothController.bluetoothState.value ==
              BluetoothAdapterState.on) {
            return Column(
              children: [
                // Dispositivo conectado
                if (bluetoothController.connectedDevice.value != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Connected to: ${(bluetoothController.connectedDevice.value!.name != '') ? bluetoothController.connectedDevice.value!.name : 'Unknown Device'}',
                        style: AppTheme.style.bold.copyWith(fontSize: 19),
                      ),
                      Text(
                        'State: ${bluetoothController.connectionState.value.toString().split('.').last}',
                        style: AppTheme.style.regular.copyWith(fontSize: 19),
                      ),
                    ],
                  ).paddingAll(16),

                // Botón para escanear dispositivos
                PrimaryButton(
                  onPressed: bluetoothController.startScan,
                  text: 'Scan for Devices',
                  borderRadius: 16,
                  style: AppTheme.style.bold.copyWith(fontSize: 14),
                ).paddingAll(16),

                // Lista de dispositivos reales encontrados
                Obx(() {
                  if (bluetoothController.scanResults.isEmpty) {
                    return const Center(child: Text('No devices found.'));
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const Divider(height: 4, thickness: 2),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: bluetoothController.scanResults.length,
                      itemBuilder: (context, index) {
                        final result = bluetoothController.scanResults[index];

                        IconData signalIcon;
                        Color signalColor;
                        if (result.rssi > -50) {
                          signalIcon = Icons.signal_cellular_alt;
                          signalColor = Colors.green;
                        } else if (result.rssi > -70) {
                          signalIcon = Icons.signal_cellular_alt_2_bar;
                          signalColor = Colors.blue;
                        } else {
                          signalIcon = Icons.signal_cellular_alt_1_bar;
                          signalColor = Colors.red;
                        }

                        return ListTile(
                          title: Text(
                            result.device.name.isEmpty
                                ? 'Unknown Device'
                                : result.device.name,
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ID: ${result.device.remoteId}'),
                              FaIcon(signalIcon, color: signalColor, size: 20),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 110,
                            child: PrimaryButton(
                              borderRadius: 12,
                              onPressed: () {
                                bluetoothController
                                    .connectToDevice(result.device);
                              },
                              text: 'Connect',
                              style: AppTheme.style.bold.copyWith(fontSize: 14),
                            ),
                          ),
                        );
                      },
                    ).paddingSymmetric(horizontal: 16);
                  }
                }),
              ],
            );
          } else {
            return Center(
              child: Text(
                'Bluetooth is ${bluetoothController.bluetoothState.value.toString().split('.').last}.',
                style: AppTheme.style.regular,
              ),
            ).paddingAll(16);
          }
        }),

        // Sección de dispositivos simulados
        Text(
          'Simulated Devices'.tr,
          style: AppTheme.style.bold.copyWith(fontSize: 20),
        ).paddingOnly(top: 16, left: 16, right: 16),
        Obx(() {
          return Column(
            children: bluetoothController.simulatedDevices.map((device) {
              return ListTile(
                title: Text(device['name']!),
                subtitle: Text('ID: ${device['id']}'),
                trailing: SizedBox(
                  width: 110,
                  child: PrimaryButton(
                    borderRadius: 12,
                    onPressed: () {
                      if (bluetoothController.connectedSimulatedDevice.value ==
                          device) {
                        bluetoothController.disconnectSimulatedDevice();
                      } else {
                        bluetoothController.connectToSimulatedDevice(device);
                      }
                    },
                    color: AppTheme.colors.appSecondary,
                    text: bluetoothController.connectedSimulatedDevice.value ==
                            device
                        ? 'Disconnect'
                        : 'Connect',
                    style: AppTheme.style.bold.copyWith(fontSize: 13),
                  ),
                ),
              );
            }).toList(),
          ).paddingSymmetric(horizontal: 16);
        }),
      ],
    );
  }

  Widget _commandButtons(BluetoothController controller) {
    return Column(
      children: [
        // Para dispositivos reales
        if (controller.connectedDevice.value != null) ...[
          PrimaryButton(
            onPressed: controller.turnOnRealDevice,
            text: 'Turn On Real Device',
            color: AppTheme.colors.appSuccess,
          ).paddingSymmetric(horizontal: 16, vertical: 8),
          PrimaryButton(
            onPressed: controller.turnOffRealDevice,
            text: 'Turn Off Real Device',
            color: AppTheme.colors.appAlert,
          ).paddingSymmetric(horizontal: 16, vertical: 8),
        ],

        // Para dispositivos simulados
        if (controller.connectedSimulatedDevice.value != null) ...[
          PrimaryButton(
            onPressed: controller.turnOnSimulatedDevice,
            text: 'Turn On Simulated Device',
            color: AppTheme.colors.appSuccess,
          ).paddingSymmetric(horizontal: 16, vertical: 8),
          PrimaryButton(
            onPressed: controller.turnOffSimulatedDevice,
            text: 'Turn Off Simulated Device',
            color: AppTheme.colors.appAlert,
          ).paddingSymmetric(horizontal: 16, vertical: 8),
        ],
      ],
    );
  }
}
