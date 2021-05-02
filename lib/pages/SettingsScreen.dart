import 'package:AlkometerApp/classes/BluetoothClass.dart';
import 'package:AlkometerApp/classes/TrackingClass.dart';
import 'package:AlkometerApp/components/BottomNavigationComponent.dart';
import 'package:AlkometerApp/components/HeaderComponent.dart';
import 'package:AlkometerApp/components/SquareComponent.dart';
import 'package:AlkometerApp/main.dart';
import 'package:AlkometerApp/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final myBlue = new BluetoothClass();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  // Initializing the Bluetooth connection state to be unknown
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  // Get the instance of the Bluetooth
  FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;
  // Track the Bluetooth connection with the remote device
  BluetoothConnection connection;

  List<BluetoothDevice> _devicesList = [];
  BluetoothDevice _device;
  bool isDisconnecting = false;
  bool _connected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      if (globals.currentConnection != null) {
        _connected = true;
      }

      setState(() {
        _bluetoothState = state;
      });
    });

    // If the bluetooth of the device is not enabled,
    // then request permission to turn on bluetooth
    // as the app starts up
    enableBluetooth();

    // Listen for further state changes
    FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
        if (globals.currentConnection != null) {
          _connected = true;
        }
        asyncGetPairedDevices();
      });
    });

    asyncGetPairedDevices();
  }

  void asyncGetPairedDevices() async {
    _devicesList = await myBlue.getPairedDevices();
  }

  /*@override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationComponent(
        currentPage: 2,
        context: context,
      ),
      body: SafeArea(
        child: Column(
          children: [
            HeaderComponent(icon: Icons.settings, title: "Indstillinger", color: Colors.green),
            Container(
              margin: EdgeInsets.only(top: 25.0),
              child: SquareComponent(
                fillings: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25.0),
                        child: Text(
                          "Bluetooth Status",
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Slå Bluetooth Til:"),
                            Switch(
                              value: _bluetoothState.isEnabled,
                              onChanged: (bool value) {
                                future() async {
                                  if (value) {
                                    await FlutterBluetoothSerial.instance.requestEnable();
                                  } else {
                                    await FlutterBluetoothSerial.instance.requestDisable();
                                  }

                                  await myBlue.getPairedDevices();

                                  if (_connected) {
                                    _disconnect();
                                  }
                                }

                                future().then((_) {
                                  setState(() {});
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Parret Enheder",
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                        child: RichText(
                          text: TextSpan(
                            text: "Status: ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: _connected ? "Tilsluttet" : "Frakoblet",
                                style: TextStyle(
                                  color: _connected ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton(
                              items: _getDeviceItems(),
                              onChanged: (value) => setState(() => _device = value),
                              value: _devicesList.isNotEmpty ? _device : null,
                            ),
                            ElevatedButton(
                              onPressed: _connected ? _disconnect : _connect,
                              child: Text(_connected ? 'Frakoble' : 'Tilslut'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          "Køn & Vægt",
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () {
                          Tracking.instance.deleteAllRecords();
                        },
                        child: Text(
                          "Delete Data",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // background
                          onPrimary: Colors.white, // foreground
                        ),
                        onPressed: () async {
                          await Tracking.instance.insert({
                            Tracking.columnDate: "01-05-2021 - 12:12",
                            Tracking.columnData: "3.14",
                          });
                          print(Tracking.instance.database);
                        },
                        child: Text("Insert Data"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Create the List of devices to be shown in Dropdown Menu
  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devicesList.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('No Devices'),
      ));
    } else {
      _devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }

  // Method to connect to bluetooth
  void _connect() async {
    if (_device == null) {
      print("No device selected");
    } else {
      print("Hi");
      await BluetoothConnection.toAddress(_device.address).then((_connection) {
        print('Connected to the device');
        globals.currentConnection = _connection;
        globals.streamBT = globals.currentConnection.input.asBroadcastStream();
        setState(() {
          _connected = true;
        });

        /*globals.currentConnection.input.listen(null).onDone(() {
          if (isDisconnecting) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (this.mounted) {
            setState(() {});
          }
        });*/
      }).catchError((error) {
        print('Cannot connect, exception occurred');
        print(error);
      });
      print("Device connected");
      print(globals.currentConnection);
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() async {
    print("Hi 2");
    await globals.currentConnection.close();
    globals.currentConnection = null;
    print("Device disconnected");
    setState(() {
      globals.currentConnection = null;
      _connected = false;
      print(_connected);
    });
  }

  // Request Bluetooth permission from the user
  Future<void> enableBluetooth() async {
    // Retrieving the current Bluetooth state
    _bluetoothState = await FlutterBluetoothSerial.instance.state;

    // If the bluetooth is off, then turn it on first
    // and then retrieve the devices that are paired.
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
      await myBlue.getPairedDevices();
      return true;
    } else {
      await myBlue.getPairedDevices();
    }
    return false;
  }
}
