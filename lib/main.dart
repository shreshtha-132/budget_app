import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_provider.dart';
import 'expense_dialog.dart';
import 'category_dialog.dart';
import 'budget_chart.dart';
import 'budget_dialog.dart';
import 'history_page.dart';
import 'edit_category_dialog.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BudgetProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BudgetTrackerHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BudgetTrackerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.pink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => BudgetDialog(),
                        ),
                        child: Text('Set Monthly Budget'),
                      ),
                      ElevatedButton(
                        onPressed: () => budgetProvider.resetBudget(),
                        child: Text('Reset for Next Month'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.pink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Total Budget: ₹${budgetProvider.totalBudget}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Spent: ₹${budgetProvider.totalSpent}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                flex: 5,
                child: Container(
                  // color: Colors.pink,
                  child: BudgetChart(),
                ),
              ),
              SizedBox(height: 20),

              // try to add the "add category button here"

              Expanded(
                flex: 1,
                child: Container(
                  // color: Colors.pink,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => AddCategoryDialog(),
                      ),
                      child: Text('Add Category And Expenses'),
                    ),
                  ),
                ),
              ),

              // ends here

              Expanded(
                flex: 7,
                // color: Colors.pink,
                child: Container(
                  child: ListView.builder(
                    itemCount: budgetProvider.categories.length,
                    itemBuilder: (context, index) {
                      final category = budgetProvider.categories[index];
                      return ListTile(
                        title: Text(category.name),
                        subtitle: Text(
                            'Spent: ₹${category.spent} / ₹${category.limit}'),
                        trailing: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) =>
                                AddExpenseDialog(categoryName: category.name),
                          ),
                        ),
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) =>
                              EditCategoryDialog(category: category.name),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) => AddCategoryDialog(),
      //   ),
      // ),
    );
  }
}
