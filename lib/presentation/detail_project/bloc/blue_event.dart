import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BlueEvent {}

class InitializeBluetoothEvent extends BlueEvent {}

class ScanDevicesEvent extends BlueEvent {}

class ConnectToDeviceEvent extends BlueEvent {
  final BluetoothDevice device;

  ConnectToDeviceEvent(this.device);
}

class DisconnectDeviceEvent extends BlueEvent {}

class ConnectToSimulatedDeviceEvent extends BlueEvent {
  final Map<String, String> simulatedDevice;

  ConnectToSimulatedDeviceEvent(this.simulatedDevice);
}

class DisconnectSimulatedDeviceEvent extends BlueEvent {}

class SendCommandEvent extends BlueEvent {
  final String command;
  final bool isSimulated;

  SendCommandEvent(this.command, {this.isSimulated = false});
}
