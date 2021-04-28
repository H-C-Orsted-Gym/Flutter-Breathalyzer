import 'package:flutter/material.dart';

class HeaderComponent extends StatelessWidget {
  IconData icon;
  String title;
  MaterialColor color;

  HeaderComponent({
    @required this.icon,
    @required this.title,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue,
            Colors.green,
          ],
        ),
      ),
      padding: EdgeInsets.only(
        top: 25.0,
        bottom: 25.0,
      ),
      child: Container(
        margin: EdgeInsets.only(left: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Skal spørge Dyrwing om ikonet skal være hvidt eller sort
            Icon(
              this.icon,
              color: Colors.white,
              size: 35.0,
            ),
            Text(
              this.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
