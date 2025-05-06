import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ providers/todo_provider.dart';
import 'custom_button.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _titleController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Task Title',
            hintText: 'Enter task title',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a task title';
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _addTodo(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        CustomButton(
          onPressed: _addTodo,
          text: 'Add Task',
        ),
      ],
    );
  }

  void _addTodo() {
    if (_formKey.currentState?.validate() == true) {
      final title = _titleController.text.trim();
      if (title.isNotEmpty) {
        Provider.of<TodoProvider>(context, listen: false).addTodo(title);
        Navigator.of(context).pop();

        // Show a snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task added successfully')),
        );
      }
    }
  }
}