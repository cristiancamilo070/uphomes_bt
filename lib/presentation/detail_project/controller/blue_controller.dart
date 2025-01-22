import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:samay_test/core/controllers/base_getx_controller.dart';

class BluetoothController extends BaseGetxController {
  final FlutterBluePlus flutterBlue = FlutterBluePlus();

  Rx<BluetoothAdapterState> bluetoothState = BluetoothAdapterState.unknown.obs;
  RxList<ScanResult> scanResults = <ScanResult>[].obs;
  Rx<BluetoothDevice?> connectedDevice = Rx<BluetoothDevice?>(null);
  Rx<BluetoothConnectionState> connectionState =
      BluetoothConnectionState.disconnected.obs;

  RxList<Map<String, String>> simulatedDevices = <Map<String, String>>[].obs;
  Rx<Map<String, String>?> connectedSimulatedDevice =
      Rx<Map<String, String>?>(null);

  late StreamSubscription<BluetoothAdapterState> _stateSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionSubscription;

  @override
  void onInit() {
    super.onInit();
    _initializeBluetooth();
    _initializeSimulatedDevices();
  }

  @override
  void onClose() {
    _stateSubscription.cancel();
    _connectionSubscription?.cancel();
    super.onClose();
  }

  void _initializeBluetooth() async {
    _stateSubscription = FlutterBluePlus.adapterState.listen((state) {
      bluetoothState.value = state;
      if (state != BluetoothAdapterState.on) {
        scanResults.clear();
        disconnectDevice();
      }
    });
  }

  void _initializeSimulatedDevices() {
    simulatedDevices.assignAll([
      {'name': 'Simulated Light', 'id': 'simulated_1'},
      {'name': 'Simulated Thermostat', 'id': 'simulated_2'},
      {'name': 'Simulated Speaker', 'id': 'simulated_3'},
    ]);
  }

// Escanea dispositivos Bluetooth cercanos
  Future<void> startScan() async {
    if (bluetoothState.value != BluetoothAdapterState.on) {
      showErrorMessage('Error', 'Bluetooth no está activado.');
      return;
    }

    scanResults.clear();

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 10)).then((_) {
      FlutterBluePlus.scanResults.listen((results) {
        final filteredResults = results.where((r) => r.rssi > -90).toList();
        scanResults.assignAll(filteredResults);
      });
    });
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      showLoading();
      await device.connect(autoConnect: false);
      connectedDevice.value = device;

      _connectionSubscription?.cancel();
      _connectionSubscription = device.connectionState.listen((state) {
        connectionState.value = state;

        if (state == BluetoothConnectionState.disconnected) {
          connectedDevice.value = null;
        }
      });

      closeLoading();
      showSuccessMessage('Éxito', 'Conectado a un Dispositivo');
    } catch (e) {
      closeLoading();
      showErrorMessage('Error', 'No se pudo conectar al dispositivo: $e');
    }
  }

  Future<void> disconnectDevice() async {
    showLoading();
    if (connectedDevice.value != null) {
      await connectedDevice.value!.disconnect();
      connectedDevice.value = null;
      connectionState.value = BluetoothConnectionState.disconnected;
      showErrorMessage('Desconexión', 'Dispositivo desconectado');
    }
    closeLoading();
  }

  void connectToSimulatedDevice(Map<String, String> device) {
    connectedSimulatedDevice.value = device;
    showSuccessMessage('Éxito', 'Conectado a ${device['name']}');
  }

  void disconnectSimulatedDevice() {
    if (connectedSimulatedDevice.value != null) {
      showSuccessMessage('Desconexión',
          'Desconectado de ${connectedSimulatedDevice.value!['name']}');
      connectedSimulatedDevice.value = null;
    }
  }

  /// **Control de dispositivos reales**
  Future<void> sendCommandToRealDevice(String command) async {
    if (connectedDevice.value == null) {
      showErrorMessage('Error', 'No hay un dispositivo conectado.');
      return;
    }

    try {
      // Aquí envías comandos al dispositivo real (dependiendo de sus características)
      showSuccessMessage('Comando enviado', 'Comando: $command');
    } catch (e) {
      showErrorMessage('Error', 'Error al enviar comando: $e');
    }
  }

  /// **Control de dispositivos simulados**
  void sendCommandToSimulatedDevice(String command) {
    if (connectedSimulatedDevice.value == null) {
      showErrorMessage('Error', 'No hay un dispositivo simulado conectado.');
      return;
    }

    showSuccessMessage('Comando enviado',
        'Comando "$command" enviado a ${connectedSimulatedDevice.value!['name']}');
  }

  /// **Encender dispositivo real**
  Future<void> turnOnRealDevice() async {
    await sendCommandToRealDevice('TURN_ON');
  }

  /// **Apagar dispositivo real**
  Future<void> turnOffRealDevice() async {
    await sendCommandToRealDevice('TURN_OFF');
  }

  /// **Encender dispositivo simulado**
  void turnOnSimulatedDevice() {
    sendCommandToSimulatedDevice('TURN_ON');
  }

  /// **Apagar dispositivo simulado**
  void turnOffSimulatedDevice() {
    sendCommandToSimulatedDevice('TURN_OFF');
  }
}

abstract class Device {
  String get name;
  String get id;

  Future<void> turnOn();
  Future<void> turnOff();
  Future<String> getData();
}

class RealBluetoothDevice implements Device {
  final BluetoothDevice device;
  final Guid characteristicUuid; // UUID de la característica para control

  RealBluetoothDevice(this.device, this.characteristicUuid);

  @override
  String get name => device.name;

  @override
  String get id => device.remoteId.toString();

  @override
  Future<void> turnOn() async {
    final characteristic = await _getCharacteristic();
    await characteristic.write([0x01]); // Suponiendo que 0x01 es "encender"
  }

  @override
  Future<void> turnOff() async {
    final characteristic = await _getCharacteristic();
    await characteristic.write([0x00]); // Suponiendo que 0x00 es "apagar"
  }

  @override
  Future<String> getData() async {
    final characteristic = await _getCharacteristic();
    final data = await characteristic.read();
    return String.fromCharCodes(data);
  }

  Future<BluetoothCharacteristic> _getCharacteristic() async {
    final services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid == characteristicUuid) {
          return characteristic;
        }
      }
    }
    throw Exception('Characteristic not found');
  }
}

class SimulatedDevice implements Device {
  final String _name;
  final String _id;
  bool _isOn = false;

  SimulatedDevice(this._name, this._id);

  @override
  String get name => _name;

  @override
  String get id => _id;

  @override
  Future<void> turnOn() async {
    _isOn = true;
    await Future.delayed(
        Duration(milliseconds: 500)); // Simula tiempo de respuesta
    print('$name turned on');
  }

  @override
  Future<void> turnOff() async {
    _isOn = false;
    await Future.delayed(
        Duration(milliseconds: 500)); // Simula tiempo de respuesta
    print('$name turned off');
  }

  @override
  Future<String> getData() async {
    await Future.delayed(
        Duration(milliseconds: 500)); // Simula tiempo de respuesta
    return _isOn
        ? 'Simulated data: Device is ON'
        : 'Simulated data: Device is OFF';
  }
}
