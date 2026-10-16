// lib/app.dart
import 'package:expense_manager/features/expenses/expense_list_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: const ExpenseListScreen(),
    );
  }
}