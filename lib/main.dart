import 'package:AlkometerApp/pages/HomeScreen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    new MaterialApp(
      home: App(),
    ),
  );
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}

Route createRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

void showMessage(GlobalKey<ScaffoldState> inputScaffoldKey, String inputMessage) {
  final snackBar = SnackBar(
    content: Text(inputMessage),
  );
  inputScaffoldKey.currentState.showSnackBar(snackBar);
}
