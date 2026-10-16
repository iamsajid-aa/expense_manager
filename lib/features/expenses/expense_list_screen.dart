import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../core/utils/category_icons.dart';
import '../../data/providers.dart';
import 'add_expense_screen.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expensesProvider);
    final money = NumberFormat.simpleCurrency();

    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
        ),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      body: expenses.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Something went wrong: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('No expenses yet. Tap Add to start.'));
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final item = items[i];
              final color = Color(item.category.colorValue);
              return Dismissible(
                key: ValueKey(item.expense.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.delete),
                ),
                onDismissed: (_) => ref
                    .read(expenseRepositoryProvider)
                    .delete(item.expense.id),
                child: Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: color.withValues(alpha: 0.15),
                      child: Icon(iconFor(item.category.iconKey), color: color),
                    ),
                    title: Text(item.category.name),
                    subtitle: Text(
                      [
                        DateFormat.yMMMd().format(item.expense.date),
                        if (item.expense.note?.isNotEmpty ?? false)
                          item.expense.note!,
                      ].join(' · '),
                    ),
                    trailing: Text(
                      money.format(item.expense.amountMinor / 100),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}