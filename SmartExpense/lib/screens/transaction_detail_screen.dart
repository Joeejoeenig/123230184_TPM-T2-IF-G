// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../models/transaction_model.dart';

// class TransactionDetailScreen extends StatelessWidget {
//   final TransactionModel transaction;

//   const TransactionDetailScreen({
//     super.key,
//     required this.transaction,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isIncome = transaction.type == "Income";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Transaction Detail"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Card(
//           child: Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 Center(
//                   child: Icon(
//                     isIncome
//                         ? Icons.arrow_downward
//                         : Icons.arrow_upward,
//                     size: 60,
//                     color:
//                         isIncome ? Colors.green : Colors.red,
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 const Text(
//                   "Amount",
//                   style: TextStyle(color: Colors.grey),
//                 ),

//                 Text(
//                   "Rp ${transaction.amount.toStringAsFixed(0)}",
//                   style: const TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const Divider(height: 35),

//                 ListTile(
//                   leading: const Icon(Icons.category),
//                   title: const Text("Category"),
//                   subtitle: Text(transaction.category),
//                 ),

//                 ListTile(
//                   leading: const Icon(Icons.swap_horiz),
//                   title: const Text("Type"),
//                   subtitle: Text(transaction.type),
//                 ),

//                 ListTile(
//                   leading: const Icon(Icons.calendar_month),
//                   title: const Text("Date"),
//                   subtitle: Text(
//                     DateFormat(
//                       'dd MMMM yyyy',
//                     ).format(transaction.date),
//                   ),
//                 ),

//                 ListTile(
//                   leading: const Icon(Icons.notes),
//                   title: const Text("Notes"),
//                   subtitle: Text(
//                     transaction.note.isEmpty
//                         ? "-"
//                         : transaction.note,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../models/transaction_model.dart';
// import '../utils/currency_formatter.dart';

// class TransactionDetailScreen extends StatelessWidget {
//   final TransactionModel transaction;

//   const TransactionDetailScreen({
//     super.key,
//     required this.transaction,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isIncome = transaction.type == "Income";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Transaction Detail"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(24),
//                 child: Column(
//                   children: [
//                     CircleAvatar(
//                       radius: 40,
//                       backgroundColor: isIncome
//                           ? Colors.green.shade100
//                           : Colors.red.shade100,
//                       child: Icon(
//                         isIncome
//                             ? Icons.arrow_downward
//                             : Icons.arrow_upward,
//                         size: 40,
//                         color:
//                             isIncome ? Colors.green : Colors.red,
//                       ),
//                     ),

//                     const SizedBox(height: 20),

//                     Text(
//                       CurrencyFormatter.format(
//                         transaction.amount,
//                       ),
//                       style: const TextStyle(
//                         fontSize: 30,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     Chip(
//                       label: Text(transaction.type),
//                       backgroundColor: isIncome
//                           ? Colors.green.shade100
//                           : Colors.red.shade100,
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 25),

//             Card(
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: const Icon(Icons.category),
//                     title: const Text("Category"),
//                     subtitle: Text(transaction.category),
//                   ),

//                   const Divider(height: 1),

//                   ListTile(
//                     leading: const Icon(Icons.calendar_month),
//                     title: const Text("Date"),
//                     subtitle: Text(
//                       DateFormat(
//                         "EEEE, dd MMMM yyyy",
//                       ).format(transaction.date),
//                     ),
//                   ),

//                   const Divider(height: 1),

//                   ListTile(
//                     leading: const Icon(Icons.notes),
//                     title: const Text("Notes"),
//                     subtitle: Text(
//                       transaction.note.isEmpty
//                           ? "-"
//                           : transaction.note,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import '../utils/currency_formatter.dart';
import 'edit_transaction_screen.dart';

class TransactionDetailScreen extends StatefulWidget {
  final TransactionModel transaction;

  const TransactionDetailScreen({
    super.key,
    required this.transaction,
  });

  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState
    extends State<TransactionDetailScreen> {
  late TransactionModel transaction;

  @override
  void initState() {
    super.initState();
    transaction = widget.transaction;
  }

  Future<void> _editTransaction() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EditTransactionScreen(
          transaction: transaction,
        ),
      ),
    );

    if (result == true && mounted) {
      final provider =
          context.read<TransactionProvider>();

      final updated = provider.transactions.firstWhere(
        (e) => e.id == transaction.id,
      );

      setState(() {
        transaction = updated;
      });
    }
  }

  Future<void> _deleteTransaction() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Transaction"),
        content: const Text(
          "Are you sure you want to delete this transaction?\n\nThis action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await context
        .read<TransactionProvider>()
        .deleteTransaction(transaction.id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Transaction deleted successfully",
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isIncome =
        transaction.type == "Income";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction Detail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: "Edit",
            onPressed: _editTransaction,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Delete",
            onPressed: _deleteTransaction,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: isIncome
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                      child: Icon(
                        isIncome
                            ? Icons.arrow_downward
                            : Icons.arrow_upward,
                        color: isIncome
                            ? Colors.green
                            : Colors.red,
                        size: 40,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      CurrencyFormatter.format(
                        transaction.amount,
                      ),
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Chip(
                      label: Text(transaction.type),
                      backgroundColor: isIncome
                          ? Colors.green.shade100
                          : Colors.red.shade100,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading:
                        const Icon(Icons.category),
                    title: const Text("Category"),
                    subtitle:
                        Text(transaction.category),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(
                        Icons.calendar_month),
                    title: const Text("Date"),
                    subtitle: Text(
                      DateFormat(
                        "EEEE, dd MMMM yyyy",
                      ).format(transaction.date),
                    ),
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading:
                        const Icon(Icons.notes),
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

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _editTransaction,
                icon: const Icon(Icons.edit),
                label: const Text(
                  "Edit Transaction",
                ),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _deleteTransaction,
                icon: const Icon(Icons.delete),
                label: const Text(
                  "Delete Transaction",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}