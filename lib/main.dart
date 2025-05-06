import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import ' providers/todo_provider.dart';
import 'screens/todo_list_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const TodoListScreen(),
      ),
    );
  }
}