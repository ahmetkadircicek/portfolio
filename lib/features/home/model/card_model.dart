import 'package:flutter/material.dart';

class CardModel {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final String category;
  final Color firstColor;
  final Color secondColor;
  final Alignment titleAlignment;

  const CardModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.category,
    required this.firstColor,
    required this.secondColor,
    this.titleAlignment = Alignment.centerLeft,
  });
}
