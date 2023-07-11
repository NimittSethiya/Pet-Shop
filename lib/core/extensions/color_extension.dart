import 'package:flutter/material.dart';
import 'dart:math' as math;

extension RandomColor on Color{
  static Color getRandomColor() =>
  Color((math.Random().nextDouble() * 0xFF0000).toInt())
      .withOpacity(0.6);
}