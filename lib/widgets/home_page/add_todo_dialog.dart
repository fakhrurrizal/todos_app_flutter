import 'package:flutter/material.dart';
import 'package:todos_app_flutter/entities/category.dart';
import 'package:todos_app_flutter/entities/todo.dart';

class AddTodoDialog extends StatefulWidget {
  final Function(Todo) onAddTodo;
  final List<TodoCategory> categories;

  const AddTodoDialog(
      {Key? key, required this.onAddTodo, required this.categories})
      : super(key: key);

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDescription = TextEditingController();
  int _selectedCategoryId = 1;

  void _addTodo() {
    if (_controllerTitle.text.isNotEmpty) {
      final newTodo = Todo(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _controllerTitle.text,
        description: _controllerDescription.text,
        isCompleted: false,
        categoryId: _selectedCategoryId,
        createdAt: DateTime.now(),
      );
      widget.onAddTodo(newTodo);
      _controllerTitle.clear();
      _controllerDescription.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Buat Rencana'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controllerTitle,
            decoration: const InputDecoration(labelText: 'Judul'),
          ),
          TextField(
            controller: _controllerDescription,
            decoration: const InputDecoration(labelText: 'Keterangan'),
          ),
          DropdownButton<int>(
            value: _selectedCategoryId,
            onChanged: (int? newValue) {
              setState(() {
                _selectedCategoryId = newValue!;
              });
            },
            items: widget.categories.map((TodoCategory category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: _addTodo,
          child: const Text('Buat'),
        ),
      ],
    );
  }
}
