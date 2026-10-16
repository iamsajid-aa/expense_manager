import 'package:flutter/material.dart';

const categoryIcons = <String, IconData>{
  'food': Icons.restaurant,
  'transport': Icons.directions_bus,
  'shopping': Icons.shopping_bag,
  'bills': Icons.receipt_long,
  'health': Icons.favorite,
  'other': Icons.category,
};

IconData iconFor(String key) => categoryIcons[key] ?? Icons.category;