import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<TodoModel> _todos = [];
  final _uuid = const Uuid();

  // Get all todos
  List<TodoModel> get todos => List.unmodifiable(_todos);

  // Add a new todo
  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    final newTodo = TodoModel(
      id: _uuid.v4(),
      title: title.trim(),
    );

    _todos.add(newTodo);
    notifyListeners();
  }

  // Toggle todo completion status
  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
          isCompleted: !_todos[index].isCompleted
      );
      notifyListeners();
    }
  }

  // Delete a todo
  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }
}