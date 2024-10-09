import 'package:flutter/material.dart';

class TodoCategory {
  final int id;
  final String name;
  final Color color;

  // Ensure the constructor has named parameters.
  TodoCategory({
    required this.id,
    required this.name,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'color': color.value,
    };
  }

  factory TodoCategory.fromMap(Map<String, dynamic> map) {
    return TodoCategory(
      id: map['id'],
      name: map['name'],
      color: Color(map['color']),
    );
  }
}
