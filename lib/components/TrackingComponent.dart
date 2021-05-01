import 'package:AlkometerApp/classes/TrackingClass.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrackingComponent extends StatelessWidget {
  int id;
  double promille;
  DateTime dateTracked;

  TrackingComponent({
    @required this.id,
    @required this.promille,
    @required this.dateTracked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.0,
        right: 15.0,
        left: 15.0,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black54,
            width: 1.0,
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(
          right: 10.0,
          left: 10.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Forskellig farve cirkel på baggrund af promillen
            Row(
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  margin: EdgeInsets.only(
                    right: 10.0,
                  ),
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: "Promille: ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: this.promille.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Tid: ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            //text: '${this.dateTracked.day}/${this.dateTracked.month}/${this.dateTracked.year} - ${this.dateTracked.hour}:${this.dateTracked.minute}',
                            text: DateFormat('dd/MM/yyyy – kk:mm').format(DateTime.now()),
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              child: Icon(
                Icons.delete,
                size: 28.0,
                color: Colors.lightBlue,
              ),
              onTap: () {
                Tracking.instance.delete(this.id);

                /*

                  int i await Tracking.instance.insert({
                    Tracking._columnDate : ".....",
                    Tracking._columnData : "3.14"
                  });
                
                */
              },
            )
          ],
        ),
      ),
    );
  }
}
