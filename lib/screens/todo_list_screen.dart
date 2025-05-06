import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/widgets/empty_state.dart';
import 'package:todo_app/widgets/todo_list_item.dart';
import '../ providers/todo_provider.dart';
import '../widgets/add_todo_dialog.dart';


class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        centerTitle: true,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, _) {
          final todos = todoProvider.todos;

          if (todos.isEmpty) {
            return const EmptyState(
              icon: Icons.task_alt,
              message: 'No tasks yet',
              description: 'Add your first task by tapping the + button',
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TodoListItem(
                  todo: todo,
                  onToggle: () => todoProvider.toggleTodoStatus(todo.id),
                  onDelete: () => todoProvider.deleteTodo(todo.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddTodoDialog(),
    );
  }
}