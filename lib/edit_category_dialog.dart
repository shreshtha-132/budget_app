import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_provider.dart';
import 'budget_provider.dart';

class EditCategoryDialog extends StatefulWidget {
  final String category;

  EditCategoryDialog({required this.category});

  @override
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _newName;
  late double _newLimit;

  @override
  void initState() {
    super.initState();
    _newName = widget.category;
    _newLimit = Provider.of<BudgetProvider>(context, listen: false)
        .categories
        .firstWhere((category) => category.name == widget.category)
        .limit;
  }

  @override
  Widget build(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    return AlertDialog(
      title: Text("Edit/Delete Category"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: _newName,
              decoration: InputDecoration(labelText: 'Category Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Category Name';
                }
                return null;
              },
              onSaved: (value) {
                _newName = value!;
              },
            ),
            TextFormField(
              initialValue: _newLimit.toString(),
              decoration: InputDecoration(labelText: 'Category Limit'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a Category Limit';
                }
                return null;
              },
              onSaved: (value) {
                _newLimit = double.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            budgetProvider.deleteCategory(widget.category);
            Navigator.of(context).pop();
          },
          child: Text('Delete'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              budgetProvider.editCategory(widget.category, _newName, _newLimit);
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
