import 'package:flutter/material.dart';
import 'package:todos_app_flutter/entities/todo.dart';

class EditTodoDialog extends StatefulWidget {
  final Todo todo;
  final Function(String title, String description, DateTime updatedAt) onSave;

  const EditTodoDialog({
    Key? key,
    required this.todo,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.todo.title;
    _descriptionController.text = widget.todo.description;
  }

  void _save() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      // Call the onSave function with updated date
      widget.onSave(title, description, DateTime.now());
      Navigator.of(context).pop(); // Close the dialog
    } else {
      // Show an error message if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
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
