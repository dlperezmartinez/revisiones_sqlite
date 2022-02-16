import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:arnesrevisionsqlite/model/arnes.dart';

final _lightColors = [
  Colors.grey[150],
];

class ArnesCardWidget extends StatelessWidget {
  ArnesCardWidget({
    Key? key,
    required this.arnes,
    required this.id,
  }) : super(key: key);

  final Arnes arnes;
  final int id;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[id % _lightColors.length];
    final time = DateFormat.yMMMd().format(arnes.revision);
    final minHeight = getMinHeight(id);

    return Card(
      color: color,
      child: Container(
        //constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              arnes.nombre,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              time,
              style: TextStyle(color: Colors.grey.shade700),
            ),
            // Divider(
            //   height: 2,
            //   color: Colors.grey[700],
            // ),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
