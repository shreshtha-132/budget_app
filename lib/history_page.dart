import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_provider.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Column(children: [
        ListView.builder(
          itemCount: budgetProvider.history.length,
          itemBuilder: (context, index) {
            final record = budgetProvider.history[index];
            return ListTile(
              title: Text(
                  '${record.date.month}/${record.date.year} - Budget: ₹${record.budget}, Spent: ₹${record.spent}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: record.categories
                    .map((category) => Text(
                        '${category.name}: ₹${category.spent} / ₹${category.limit}'))
                    .toList(),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ElevatedButton(
            onPressed: () {
              Provider.of<BudgetProvider>(context, listen: false)
                  .clearHistory();
            },
            child: Text('Clear History'),
          ),
        ),
      ]),
    );
  }
}
