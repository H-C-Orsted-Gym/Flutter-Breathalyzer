import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

class BluetoothClass {
  Future<List<BluetoothDevice>> getPairedDevices() async {
    List<BluetoothDevice> devices = [];

    // To get the list of paired devices
    try {
      devices = await _bluetooth.getBondedDevices();
    } on PlatformException {
      print("Error");
    }

    // Store the [devices] list in the [_devicesList] for accessing
    // the list outside this class
    return devices;
  }
}
