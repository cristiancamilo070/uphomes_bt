import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class BlueState {}

class BlueInitialState extends BlueState {}

class BlueLoadingState extends BlueState {}

class BluetoothAdapterStateChanged extends BlueState {
  final BluetoothAdapterState state;

  BluetoothAdapterStateChanged(this.state);
}

class BluetoothScanResultsState extends BlueState {
  final List<ScanResult> devices;

  BluetoothScanResultsState(this.devices);
}

class BluetoothConnectedState extends BlueState {
  final BluetoothDevice? device;
  final Map<String, String>? simulatedDevice;

  BluetoothConnectedState({this.device, this.simulatedDevice});
}

class BluetoothDisconnectedState extends BlueState {}

class BlueCommandSuccessState extends BlueState {
  final String message;

  BlueCommandSuccessState(this.message);
}

class BlueErrorState extends BlueState {
  final String error;

  BlueErrorState(this.error);
}
