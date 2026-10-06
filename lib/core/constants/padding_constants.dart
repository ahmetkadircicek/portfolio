import 'package:flutter/material.dart';

class PaddingConstants {
  PaddingConstants._();

  static const double small = 8;
  static const double medium = 16;
  static const double large = 24;

  static const EdgeInsets allSmall = EdgeInsets.all(small);
  static const EdgeInsets allMedium = EdgeInsets.all(medium);
  static const EdgeInsets allLarge = EdgeInsets.all(large);

  static const EdgeInsets symmetricHorizontalSmall = EdgeInsets.symmetric(horizontal: small);
  static const EdgeInsets symmetricHorizontalMedium = EdgeInsets.symmetric(horizontal: medium);
  static const EdgeInsets symmetricHorizontalLarge = EdgeInsets.symmetric(horizontal: large);

  static const EdgeInsets symmetricVerticalSmall = EdgeInsets.symmetric(vertical: small);
  static const EdgeInsets symmetricVerticalMedium = EdgeInsets.symmetric(vertical: medium);
  static const EdgeInsets symmetricVerticalLarge = EdgeInsets.symmetric(vertical: large);
}
