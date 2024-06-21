import 'package:flutter/material.dart';

class BudgetProvider with ChangeNotifier {
  double totalBudget = 0.0;
  double totalSpent = 0.0;

  List<Category> categories = [];
  List<MonthRecord> history = [];

  void setMonthlyBudget(double budget) {
    totalBudget = budget;
    notifyListeners();
  }

  void resetBudget() {
    history.add(MonthRecord(DateTime.now(), totalBudget, totalSpent,
        _deepCopyCategories(categories)));
    totalSpent = 0.0;
    categories.forEach((category) => category.spent = 0.0);
    notifyListeners();
  }

  List<Category> _deepCopyCategories(List<Category> categories) {
    return categories
        .map((category) => Category(
            name: category.name, spent: category.spent, limit: category.limit))
        .toList();
  }

  void addCategory(String name, double limit) {
    categories.add(Category(name: name, limit: limit));
    notifyListeners();
  }

  void addExpense(String categoryName, double amount) {
    final category = categories.firstWhere((cat) => cat.name == categoryName);
    category.spent += amount;
    totalSpent += amount;
    notifyListeners();
  }

  void editCategory(String oldName, String newName, double newLimit) {
    for (var category in categories) {
      if (category.name == oldName) {
        category.name = newName;
        category.limit = newLimit;
        break;
      }
    }
    notifyListeners();
  }

  void deleteCategory(String categoryName) {
    categories.removeWhere((category) => category.name == categoryName);
    notifyListeners();
  }

  void clearHistory() {}
}

class Category {
  String name;
  double spent;
  double limit;

  Category({required this.name, this.spent = 0.0, required this.limit});
}

class MonthRecord {
  final DateTime date;
  final double budget;
  final double spent;
  final List<Category> categories;

  MonthRecord(this.date, this.budget, this.spent, this.categories);
}
