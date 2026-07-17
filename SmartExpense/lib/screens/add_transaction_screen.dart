// import 'package:flutter/material.dart';

// class AddTransactionScreen extends StatelessWidget {
//   const AddTransactionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Transaction"),
//       ),
//       body: const Center(
//         child: Text(
//           "Add Transaction",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState
    extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController amountController =
      TextEditingController();

  final TextEditingController noteController =
      TextEditingController();

  String selectedCategory = "Food";

  String selectedType = "Expense";

  DateTime selectedDate = DateTime.now();

  final List<String> categories = [
    "Food",
    "Transportation",
    "Entertainment",
    "Shopping",
    "Education",
    "Health",
    "Salary",
    "Other"
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
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

                  if (double.tryParse(value) == null) {
                    return "Invalid amount";
                  }

                  if (double.parse(value) <= 0) {
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
                //   onPressed: () {

                //     if (_formKey.currentState!.validate()) {

                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text(
                //             "Next Step: Save Transaction",
                //           ),
                //         ),
                //       );

                //     }
                    
                    onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;
                        
                        final transaction = TransactionModel(
                            id: const Uuid().v4(),
                            amount: double.parse(amountController.text),
                            category: selectedCategory,
                            type: selectedType,
                            date: selectedDate,
                            note: noteController.text,
                        );
                        
                        await context.read<TransactionProvider>().addTransaction(transaction);
                        
                        if (!context.mounted) return;
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Transaction saved successfully"),
                            ),
                        );
                        
                        amountController.clear();
                        noteController.clear();
                        
                        setState(() {
                            selectedCategory = "Food";
                            selectedType = "Expense";
                            selectedDate = DateTime.now();
                        });
                    },
                  icon: const Icon(Icons.save),
                  label: const Text("Save Transaction"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}