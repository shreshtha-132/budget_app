import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_provider.dart';

class BudgetDialog extends StatefulWidget {
  @override
  _BudgetDialogState createState() => _BudgetDialogState();
}

class _BudgetDialogState extends State<BudgetDialog> {
  final _formKey = GlobalKey<FormState>();
  double? _budget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Set Monthly Budget'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.number,
          onSaved: (value) {
            _budget = double.tryParse(value!);
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a budget';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            return null;
          },
          decoration: InputDecoration(labelText: 'Budget'),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              Provider.of<BudgetProvider>(context, listen: false)
                  .setMonthlyBudget(_budget!);
              Navigator.of(context).pop();
            }
          },
          child: Text('Set'),
        ),
      ],
    );
  }
}
