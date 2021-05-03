import 'package:AlkometerApp/components/TrackingComponent.dart';
import 'package:flutter/material.dart';

class TrackingList extends StatelessWidget {
  List<Map<String, Object>> data;

  TrackingList({
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return Text("Ingen foretaget målinger...");
    } else {
      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          print(data[index]);
          return TrackingComponent(
            id: data[index]["Id"],
            promille: double.parse(data[index]["DataTracked"]),
            dateTracked: data[index]["DateTracked"],
          );
        },
      );
    }
  }
}
