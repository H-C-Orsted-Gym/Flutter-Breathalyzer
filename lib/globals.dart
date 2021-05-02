library my_prj.globals;

import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

BluetoothConnection currentConnection = null;

Stream<Uint8List> streamBT = null;
