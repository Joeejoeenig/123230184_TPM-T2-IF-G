import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction_model.dart';

class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == "Income";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Center(
                  child: Icon(
                    isIncome
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    size: 60,
                    color:
                        isIncome ? Colors.green : Colors.red,
                  ),
                ),

                const SizedBox(height: 25),

                const Text(
                  "Amount",
                  style: TextStyle(color: Colors.grey),
                ),

                Text(
                  "Rp ${transaction.amount.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Divider(height: 35),

                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text("Category"),
                  subtitle: Text(transaction.category),
                ),

                ListTile(
                  leading: const Icon(Icons.swap_horiz),
                  title: const Text("Type"),
                  subtitle: Text(transaction.type),
                ),

                ListTile(
                  leading: const Icon(Icons.calendar_month),
                  title: const Text("Date"),
                  subtitle: Text(
                    DateFormat(
                      'dd MMMM yyyy',
                    ).format(transaction.date),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.notes),
                  title: const Text("Notes"),
                  subtitle: Text(
                    transaction.note.isEmpty
                        ? "-"
                        : transaction.note,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}