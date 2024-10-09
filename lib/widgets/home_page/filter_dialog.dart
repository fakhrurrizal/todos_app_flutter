import 'package:flutter/material.dart';

class FilterDialog extends StatefulWidget {
  final int? selectedCategoryId;
  final Function(int?) onCategorySelected;

  const FilterDialog({
    Key? key,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Rencana'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Kategori'),
              value: widget.selectedCategoryId,
              onChanged: (int? newValue) {
                widget.onCategorySelected(newValue);
              },
              items: const [
                DropdownMenuItem<int>(
                  value: null,
                  child: Text('Semua Kategori'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('Pekerjaan'),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('Pribadi'),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text('Belanja'),
                ),
                DropdownMenuItem<int>(
                  value: 4,
                  child: Text('Lainya'),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text('Selesai'),
        ),
      ],
    );
  }
}
