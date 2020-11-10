import 'package:ashva_fitness_example/import/badge_icons_icons.dart';
import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final IconData badge;
  final int count, distance;

  const BadgeWidget({Key key, this.badge, this.count, this.distance})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          Text(count.toString(),
              style: TextStyle(color: Colors.white, fontSize: 12)),
          Icon(
            badge,
            color: Colors.white,
          ),
          Text('${distance.toString()}',
              style: TextStyle(color: Colors.white, fontSize: 12))
        ],
      ),
    );
  }
}
