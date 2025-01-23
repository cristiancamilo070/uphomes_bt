import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'blue_event.dart';
import 'blue_state.dart';

class BlueBloc extends Bloc<BlueEvent, BlueState> {
  final FlutterBluePlus flutterBlue;
  BluetoothDevice? _connectedDevice;
  Map<String, String>? _connectedSimulatedDevice;
  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

  BlueBloc(this.flutterBlue) : super(BlueInitialState()) {
    on<InitializeBluetoothEvent>(_initializeBluetooth);
    on<ScanDevicesEvent>(_scanDevices);
    on<ConnectToDeviceEvent>(_connectToDevice);
    on<DisconnectDeviceEvent>(_disconnectDevice);
    on<ConnectToSimulatedDeviceEvent>(_connectToSimulatedDevice);
    on<DisconnectSimulatedDeviceEvent>(_disconnectSimulatedDevice);
    on<SendCommandEvent>(_sendCommand);
  }

  void _initializeBluetooth(
      InitializeBluetoothEvent event, Emitter<BlueState> emit) async {
    // Emitir estado inicial del adaptador
    await emit.forEach<BluetoothAdapterState>(
      FlutterBluePlus.adapterState,
      onData: (state) => BluetoothAdapterStateChanged(state),
      onError: (error, stackTrace) =>
          BlueErrorState('Error al inicializar Bluetooth: $error'),
    );
  }

  void _scanDevices(ScanDevicesEvent event, Emitter<BlueState> emit) async {
    emit(BlueLoadingState());
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
      final devices = await FlutterBluePlus.scanResults.first;
      emit(BluetoothScanResultsState(devices));
    } catch (e) {
      emit(BlueErrorState(e.toString()));
    }
  }

  void _connectToDevice(
      ConnectToDeviceEvent event, Emitter<BlueState> emit) async {
    emit(BlueLoadingState());
    try {
      await event.device.connect();
      _connectedDevice = event.device;
      emit(BluetoothConnectedState(device: event.device));
    } catch (e) {
      emit(BlueErrorState(e.toString()));
    }
  }

  void _disconnectDevice(
      DisconnectDeviceEvent event, Emitter<BlueState> emit) async {
    emit(BlueLoadingState());
    try {
      await _connectedDevice?.disconnect();
      _connectedDevice = null;
      emit(BluetoothDisconnectedState());
    } catch (e) {
      emit(BlueErrorState(e.toString()));
    }
  }

  void _connectToSimulatedDevice(
      ConnectToSimulatedDeviceEvent event, Emitter<BlueState> emit) {
    _connectedSimulatedDevice = event.simulatedDevice;
    emit(BluetoothConnectedState(simulatedDevice: event.simulatedDevice));
  }

  void _disconnectSimulatedDevice(
      DisconnectSimulatedDeviceEvent event, Emitter<BlueState> emit) {
    _connectedSimulatedDevice = null;
    emit(BluetoothDisconnectedState());
  }

  void _sendCommand(SendCommandEvent event, Emitter<BlueState> emit) {
    if (event.isSimulated) {
      if (_connectedSimulatedDevice == null) {
        emit(BlueErrorState('No simulated device connected'));
        return;
      }
      emit(BlueCommandSuccessState(
          'Command "${event.command}" sent to ${_connectedSimulatedDevice!['name']}'));
    } else {
      if (_connectedDevice == null) {
        emit(BlueErrorState('No real device connected'));
        return;
      }
      emit(BlueCommandSuccessState(
          'Command "${event.command}" sent to ${_connectedDevice?.name}'));
    }
  }

  /// Cierra las suscripciones al finalizar el Bloc
  @override
  Future<void> close() {
    _adapterStateSubscription.cancel();
    return super.close();
  }
}
