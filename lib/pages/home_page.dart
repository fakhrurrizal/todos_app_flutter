import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:tugas_1/core/assets/assets.dart';
import 'package:tugas_1/entities/category.dart';
import 'package:tugas_1/entities/todo.dart';
import 'package:tugas_1/widgets/custom_checkbox.dart';
import 'package:tugas_1/widgets/home_page/confirm_delete.dart';
import 'package:tugas_1/widgets/home_page/edit_todo_dialog.dart';
import 'package:tugas_1/widgets/home_page/filter_dialog.dart';
import 'package:tugas_1/widgets/snackbar_custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/home_page/add_todo_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Todo> _todos = [];
  final List<TodoCategory> _categories = [
    TodoCategory(id: 1, name: 'Pekerjaan', color: Colors.blue),
    TodoCategory(id: 2, name: 'Pribadi', color: Colors.green),
    TodoCategory(id: 3, name: 'Belanja', color: Colors.orange),
    TodoCategory(id: 4, name: 'Lainya', color: Colors.purple),
  ];

  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');

    if (todosString != null) {
      final List<dynamic> todosJson = jsonDecode(todosString);
      setState(() {
        _todos.addAll(todosJson.map((json) => Todo.fromJson(json)).toList());
      });
    }
  }

  Future<void> _saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todosJson =
        _todos.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setString('todos', jsonEncode(todosJson));
  }

  void _addTodo(Todo todo) {
    setState(() {
      _todos.add(todo);
    });
    _saveTodos();
  }

  void _toggleTodoCompletion(int index) {
    setState(() {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
        updatedAt: DateTime.now(),
      );
    });

    _saveTodos();
  }

  void _showAddTodoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddTodoDialog(
          onAddTodo: _addTodo,
          categories: _categories,
        );
      },
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return FilterDialog(
          selectedCategoryId: _selectedCategoryId,
          onCategorySelected: (int? selectedCategory) {
            setState(() {
              _selectedCategoryId = selectedCategory;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> _showEditTodoDialog(BuildContext context, Todo todo, int index) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return EditTodoDialog(
          todo: todo,
          categories: _categories,
          onSave: (String title, String description, DateTime updatedAt,
              int categoryId) {
            setState(() {
              _todos[index] = todo.copyWith(
                title: title,
                description: description,
                updatedAt: updatedAt,
                categoryId: categoryId,
              );
            });
          },
        );
      },
    );
  }

  List<Todo> _filterTodos() {
    if (_selectedCategoryId == null) {
      return _todos;
    } else {
      return _todos
          .where((todo) => todo.categoryId == _selectedCategoryId)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Daftar Rencana', style: TextStyle(fontSize: 18.0)),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showFilterDialog,
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _showAddTodoDialog,
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: _filterTodos().isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Assets.images.no_data.image(width: 180, height: 180),
                    const SizedBox(height: 16),
                    const Text(
                      'Ups,\n Kamu belum memiliki rencana',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _filterTodos().length,
                itemBuilder: (context, index) {
                  final todo = _filterTodos()[index];

                  final categoryColor = _categories
                      .firstWhere(
                        (cat) => cat.id == todo.categoryId,
                        orElse: () => TodoCategory(
                            id: 0, name: 'Unknown', color: Colors.grey),
                      )
                      .color;

                  return Dismissible(
                    key: Key(todo.id.toString()),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                    ),
                    background: Container(
                      color: Colors.blue,
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      ),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.endToStart) {
                        return await showConfirmationDialog(context);
                      } else if (direction == DismissDirection.startToEnd) {
                        _showEditTodoDialog(context, todo, index);

                        return false;
                      }
                      return false;
                    },
                    onDismissed: (direction) {
                      setState(() {
                        _todos.removeAt(index);
                      });

                      showGlobalSnackbar(
                          context, '${todo.title} berhasil dihapus',
                          backgroundColor: Colors.green);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: categoryColor,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todo.description,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              todo.updatedAt != null
                                  ? 'Diubah pada: ${DateFormat('yyyy-MM-dd HH:mm').format(todo.updatedAt!.toLocal())}'
                                  : 'Dibuat pada: ${DateFormat('yyyy-MM-dd HH:mm').format(todo.createdAt.toLocal())}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                            ),
                          ],
                        ),
                        trailing: CustomCheckbox(
                          value: todo.isCompleted,
                          onChanged: (value) {
                            _toggleTodoCompletion(index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
