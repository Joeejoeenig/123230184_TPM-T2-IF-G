import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<EditTransactionScreen> createState() =>
      _EditTransactionScreenState();
}

class _EditTransactionScreenState
    extends State<EditTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController amountController;
  late TextEditingController noteController;

  late String selectedCategory;
  late String selectedType;
  late DateTime selectedDate;

  final List<String> categories = [
    "Food",
    "Transportation",
    "Entertainment",
    "Shopping",
    "Education",
    "Health",
    "Salary",
    "Other",
  ];

  @override
  void initState() {
    super.initState();

    amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );

    noteController = TextEditingController(
      text: widget.transaction.note,
    );

    selectedCategory = widget.transaction.category;
    selectedType = widget.transaction.type;
    selectedDate = widget.transaction.date;
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2035),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> saveTransaction() async {
    if (!_formKey.currentState!.validate()) return;

    final updatedTransaction = TransactionModel(
      id: widget.transaction.id,
      amount: double.parse(amountController.text),
      category: selectedCategory,
      type: selectedType,
      date: selectedDate,
      note: noteController.text,
    );

    await context.read<TransactionProvider>().updateTransaction(
          widget.transaction.id,
          updatedTransaction,
        );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Transaction updated successfully"),
      ),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Transaction"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Amount",
                  prefixIcon: Icon(Icons.payments),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Amount is required";
                  }

                  final amount = double.tryParse(value);

                  if (amount == null) {
                    return "Invalid amount";
                  }

                  if (amount <= 0) {
                    return "Amount must be greater than 0";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: "Category",
                  prefixIcon: Icon(Icons.category),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_month),
                title: const Text("Transaction Date"),
                subtitle: Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                ),
                trailing: ElevatedButton(
                  onPressed: pickDate,
                  child: const Text("Select"),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Income"),
                      value: "Income",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text("Expense"),
                      value: "Expense",
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              TextFormField(
                controller: noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Notes",
                  prefixIcon: Icon(Icons.notes),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton.icon(
                  onPressed: saveTransaction,
                  icon: const Icon(Icons.save),
                  label: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}