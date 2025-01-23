// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/themes/app_theme.dart';
import 'package:samay_test/core/widgets/buttons/primary_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samay_test/presentation/detail_project/bloc/blue_bloc.dart';
import 'package:samay_test/presentation/detail_project/bloc/blue_event.dart';
import 'package:samay_test/presentation/detail_project/bloc/blue_state.dart';

class BluetoothSectionWithBloc extends StatelessWidget {
  const BluetoothSectionWithBloc({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          BlueBloc(FlutterBluePlus())..add(InitializeBluetoothEvent()),
      child: BlocBuilder<BlueBloc, BlueState>(
        builder: (context, state) {
          final blueBloc = context.read<BlueBloc>();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bluetooth Devices (Bloc)'.tr,
                style: AppTheme.style.bold.copyWith(fontSize: 20),
              ).paddingOnly(top: 16, left: 16, right: 16),
              if (state is BlueLoadingState)
                const Center(child: CircularProgressIndicator()),
              if (state is BluetoothAdapterStateChanged &&
                  state.state != BluetoothAdapterState.on)
                Center(
                  child: Text(
                    'Bluetooth is ${state.state.toString().split(".").last}',
                    style: AppTheme.style.regular,
                  ),
                ).paddingAll(16),
              if (state is BluetoothAdapterStateChanged &&
                  state.state == BluetoothAdapterState.on) ...[
                _buildScanForDevicesButton(blueBloc),
                _buildDevicesList(blueBloc),
              ],
              if (state is BluetoothConnectedState) ...[
                _buildConnectedDeviceInfo(state, blueBloc),
              ],
              _buildSimulatedDevicesList(blueBloc),
            ],
          );
        },
      ),
    );
  }

  Widget _buildScanForDevicesButton(BlueBloc blueBloc) {
    return PrimaryButton(
      onPressed: () => blueBloc.add(ScanDevicesEvent()),
      text: 'Scan for Devices',
      borderRadius: 16,
      style: AppTheme.style.bold.copyWith(fontSize: 14),
    ).paddingAll(16);
  }

  Widget _buildDevicesList(BlueBloc blueBloc) {
    return BlocBuilder<BlueBloc, BlueState>(
      builder: (context, state) {
        if (state is BluetoothScanResultsState) {
          if (state.devices.isEmpty) {
            return const Center(child: Text('No devices found.'));
          }

          return ListView.separated(
            separatorBuilder: (context, index) =>
                const Divider(height: 4, thickness: 2),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.devices.length,
            itemBuilder: (context, index) {
              final result = state.devices[index];

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
                      blueBloc.add(ConnectToDeviceEvent(result.device));
                    },
                    text: 'Connect',
                    style: AppTheme.style.bold.copyWith(fontSize: 14),
                  ),
                ),
              );
            },
          ).paddingSymmetric(horizontal: 16);
        }
        return Container();
      },
    );
  }

  Widget _buildConnectedDeviceInfo(
      BluetoothConnectedState state, BlueBloc blueBloc) {
    return Column(
      children: [
        Text(
          state.device != null
              ? 'Connected to ${state.device!.name}'
              : 'Connected to Simulated Device: ${state.simulatedDevice!['name']}',
          style: AppTheme.style.bold.copyWith(fontSize: 19),
        ),
        PrimaryButton(
          onPressed: () => blueBloc.add(
            state.device != null
                ? DisconnectDeviceEvent()
                : DisconnectSimulatedDeviceEvent(),
          ),
          text: 'Disconnect',
          color: AppTheme.colors.appAlert,
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ],
    ).paddingAll(16);
  }

  Widget _buildSimulatedDevicesList(BlueBloc blueBloc) {
    final simulatedDevices = [
      {'name': 'Simulated Light', 'id': 'sim_1'},
      {'name': 'Simulated Thermostat', 'id': 'sim_2'},
      {'name': 'Simulated Speaker', 'id': 'sim_3'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Simulated Devices'.tr,
          style: AppTheme.style.bold.copyWith(fontSize: 20),
        ).paddingOnly(top: 16, left: 16, right: 16),
        Column(
          children: simulatedDevices.map((device) {
            return ListTile(
              title: Text(device['name']!),
              subtitle: Text('ID: ${device['id']}'),
              trailing: SizedBox(
                width: 110,
                child: PrimaryButton(
                  borderRadius: 12,
                  onPressed: () {
                    blueBloc.add(ConnectToSimulatedDeviceEvent(device));
                  },
                  color: AppTheme.colors.appPrimary,
                  text: 'Connect',
                  style: AppTheme.style.bold.copyWith(fontSize: 13),
                ),
              ),
            ).paddingSymmetric(horizontal: 16);
          }).toList(),
        ),
      ],
    );
  }
}
