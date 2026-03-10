import 'package:flutter/material.dart';

class PopularModel {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool isFavorited;

  PopularModel({
    required this.name,
    required this.iconPath,
    required this.level,
    required this.duration,
    required this.calorie,
    required this.isFavorited,
  });

  static List<PopularModel> getPopularModel() {
    List<PopularModel> popularDies = [];

    popularDies.add(
      PopularModel(
        name: 'Blueberry Pancake',
        iconPath: 'assets/icon/blueberry-pancake.svg',
        level: 'Medium',
        duration: '30mins',
        calorie: '230kCal',
        isFavorited: true,
      ),
    );

    popularDies.add(
      PopularModel(
        name: 'Salmon Nigiri',
        iconPath: 'assets/icon/salmon-nigiri.svg',
        level: 'Easy',
        duration: '20mins',
        calorie: '120kCal',
        isFavorited: false,
      ),
    );

    return popularDies;
  }
}
