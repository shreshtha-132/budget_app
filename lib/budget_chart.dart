import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'budget_provider.dart';

class BudgetChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const budget_color = Color(0xFF80BCBD);
    const over_expense_color = Color(0xFFFFB996);

    const expense_color = Color(0xFFD9EDBF);

    // 80BCBD
    // Color(0xFFD9EDBF)
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final totalBudget = budgetProvider.totalBudget;
    final totalSpent = budgetProvider.totalSpent;
    final remainingBudget = totalBudget - totalSpent;
    // final data = budgetProvider.categories
    //     .map((category) => ChartData(category.name, category.spent))
    //     .toList();

    // final data = budgetProvider.categories
    //     .map((category) =>
    //         ChartData(category.name, (category.spent / totalBudget) * 100))
    //     .toList();

    final data = [
      ChartData('Spent', totalSpent),
      ChartData('Remaining', remainingBudget)
    ];

    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.amount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
          pointColorMapper: (ChartData data, _) => data.category == 'Spent'
              ? (totalSpent > totalBudget ? over_expense_color : expense_color)
              : budget_color,
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.category, this.amount);
  final String category;
  final double amount;
}
