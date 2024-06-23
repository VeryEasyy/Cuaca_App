// weather_item.dart

import 'package:flutter/material.dart';

Widget weatherItem({
  required String text,
  required int value,
  required String unit,
  required String imageUrl,
}) {
  return Column(
    children: [
      Image.asset(imageUrl, width: 50),
      Text(
        '$value$unit',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    ],
  );
}
