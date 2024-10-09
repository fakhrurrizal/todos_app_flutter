class Todo {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;
  final int categoryId;
  final DateTime createdAt; // New property for creation date
  DateTime? updatedAt;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.categoryId,
    required this.createdAt,
    this.updatedAt,
  });

  Todo copyWith({
    int? id,
    String? title,
    String? description,
    bool? isCompleted,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      categoryId: categoryId ?? this.categoryId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt':
          updatedAt?.toIso8601String() ?? '', // Convert to string for storage
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      categoryId: map['categoryId'],
      createdAt: DateTime.parse(map['createdAt']), // Parse string to DateTime
      updatedAt:
          map['updatedAt'] != '' ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}
