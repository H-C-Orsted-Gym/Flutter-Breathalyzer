import 'package:flutter/material.dart';

class CircleComponent extends StatelessWidget {
  Widget fillings;

  CircleComponent({
    @required this.fillings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.05),
      width: 250.0,
      height: 250.0,
      decoration: new BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 7.0,
        ),
      ),
      child: fillings,
    );
  }
}
