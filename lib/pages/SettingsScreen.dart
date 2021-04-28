import 'package:AlkometerApp/classes/BluetoothClass.dart';
import 'package:AlkometerApp/components/BottomNavigationComponent.dart';
import 'package:AlkometerApp/components/HeaderComponent.dart';
import 'package:AlkometerApp/components/SquareComponent.dart';
import 'package:AlkometerApp/main.dart';
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
  int _deviceState;
  bool isDisconnecting = false;
  // To track whether the device is still connected to Bluetooth
  bool get isConnected => connection != null && connection.isConnected;
  bool _connected = false;
  bool _isButtonUnavailable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    asyncMethod();
  }

  void asyncMethod() async {
    _devicesList = await myBlue.getPairedDevices();
  }

  @override
  void dispose() {
    // Avoid memory leak and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

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
                          "Paired Device:",
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
                                text: _connected ? "Connected" : "Disconnected",
                                style: TextStyle(color: _connected ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 35.0, right: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton(
                              items: _getDeviceItems(),
                              onChanged: (value) => setState(() => _device = value),
                              value: _devicesList.isNotEmpty ? _device : null,
                            ),
                            ElevatedButton(
                              onPressed: _isButtonUnavailable
                                  ? null
                                  : _connected
                                      ? _disconnect
                                      : _connect,
                              child: Text(_connected ? 'Disconnect' : 'Connect'),
                            ),
                          ],
                        ),
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
    setState(() {
      _isButtonUnavailable = true;
    });
    if (_device == null) {
      showMessage(_scaffoldKey, 'No device selected');
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(_device.address).then((_connection) {
          print('Connected to the device');
          connection = _connection;
          setState(() {
            _connected = true;
          });

          connection.input.listen(null).onDone(() {
            if (isDisconnecting) {
              print('Disconnecting locally!');
            } else {
              print('Disconnected remotely!');
            }
            if (this.mounted) {
              setState(() {});
            }
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
        showMessage(_scaffoldKey, 'Device connected');

        setState(() => _isButtonUnavailable = false);
      }
    }
  }

  // Method to disconnect bluetooth
  void _disconnect() async {
    setState(() {
      _isButtonUnavailable = true;
      _deviceState = 0;
    });

    await connection.close();
    showMessage(_scaffoldKey, 'Device disconnected');
    if (!connection.isConnected) {
      setState(() {
        _connected = false;
        _isButtonUnavailable = false;
      });
    }
  }
}
