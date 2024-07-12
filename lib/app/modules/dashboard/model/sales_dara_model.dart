import 'package:flutter/material.dart';

class SelesDateLine {
  SelesDateLine(
    this.year,
    this.sales,
    this.color,
  );
  final String year;
  final double sales;
  final Color color;
}

// Updated dummy data for SelesDateLine
final List<SelesDateLine> salesYtdLine = [
  SelesDateLine('Current', 35.0, Colors.blue),
  SelesDateLine('Target', 8.0, Colors.green),
  SelesDateLine('Last Year', 14.0, Colors.orange),
];

final List<SelesDateLine> salesMtdLine = [
  SelesDateLine('Current', 5.0, Colors.blue),
  SelesDateLine('Target', 18.0, Colors.green),
  SelesDateLine('Last Year', 14.0, Colors.orange),
];
