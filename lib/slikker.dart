import 'package:flutter/material.dart';

export 'package:slikker_kit/slikker_kit.dart';
export 'package:flutter/material.dart';

Color accentColor(double alpha, double hue, double saturation, double value) =>
    HSVColor.fromAHSV(alpha, hue, saturation, value).toColor();
