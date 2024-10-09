import 'package:flutter/material.dart';
import 'package:tugas_1/entities/category.dart';
import 'package:tugas_1/entities/todo.dart';

class EditTodoDialog extends StatefulWidget {
  final Todo todo;
  final Function(
          String title, String description, DateTime updatedAt, int categoryId)
      onSave;
  final List<TodoCategory> categories; // Pass categories to the dialog

  const EditTodoDialog({
    Key? key,
    required this.todo,
    required this.onSave,
    required this.categories, // Add categories parameter
  }) : super(key: key);

  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  int? _selectedCategoryId; // Track selected category

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
    _selectedCategoryId =
        widget.todo.categoryId; // Initialize selected category
  }

  void _save() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        _selectedCategoryId != null) {
      // Call the onSave function with updated data
      widget.onSave(title, description, DateTime.now(), _selectedCategoryId!);
      Navigator.of(context).pop(); // Close the dialog
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill in all fields and select a category')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Daftar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Judul'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Keterangan'),
          ),
          DropdownButtonFormField<int>(
            value: _selectedCategoryId,
            decoration: const InputDecoration(labelText: 'Kategori'),
            items: widget.categories.map((category) {
              return DropdownMenuItem<int>(
                value: category.id,
                child: Text(category.name),
              );
            }).toList(),
            onChanged: (int? newValue) {
              setState(() {
                _selectedCategoryId = newValue; // Update selected category
              });
            },
            hint: const Text('Pilih Kategori'), // Hint text
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: _save,
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
