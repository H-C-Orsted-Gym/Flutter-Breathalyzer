import 'package:flutter/material.dart';

class BreakLineComponent extends StatelessWidget {
  const BreakLineComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.1,
        right: MediaQuery.of(context).size.width * 0.1,
      ),
      decoration: new BoxDecoration(
        color: Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 3.0,
          ),
        ),
      ),
    );
  }
}
