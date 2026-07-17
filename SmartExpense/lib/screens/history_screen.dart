// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// import '../providers/transaction_provider.dart';
// import 'transaction_detail_screen.dart';

// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<TransactionProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Transaction History"),
//       ),
//       body: provider.transactions.isEmpty
//           ? const Center(
//               child: Text(
//                 "No transactions yet",
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                 ),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: provider.transactions.length,
//               itemBuilder: (context, index) {
//                 final transaction =
//                     provider.transactions.reversed.toList()[index];

//                 final isIncome = transaction.type == "Income";

//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 12),
//                   child: InkWell(
//                     borderRadius: BorderRadius.circular(12),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => TransactionDetailScreen(
//                             transaction: transaction,
//                           ),
//                         ),
//                       );
//                     },
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: isIncome
//                             ? Colors.green.shade100
//                             : Colors.red.shade100,
//                         child: Icon(
//                           isIncome
//                               ? Icons.arrow_downward
//                               : Icons.arrow_upward,
//                           color:
//                               isIncome ? Colors.green : Colors.red,
//                         ),
//                       ),

//                       title: Text(
//                         transaction.category,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       subtitle: Column(
//                         crossAxisAlignment:
//                             CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transaction.note.isEmpty
//                                 ? transaction.type
//                                 : transaction.note,
//                           ),

//                           const SizedBox(height: 4),

//                           Text(
//                             DateFormat("dd MMM yyyy")
//                                 .format(transaction.date),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),

//                       trailing: Text(
//                         "${isIncome ? "+" : "-"} Rp ${transaction.amount.toStringAsFixed(0)}",
//                         style: TextStyle(
//                           color: isIncome
//                               ? Colors.green
//                               : Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/transaction_provider.dart';
import '../utils/currency_formatter.dart';
import 'transaction_detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
      ),
      body: provider.transactions.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.receipt_long,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "No Transactions Yet",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Start by adding your first income or expense.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Total Transactions",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${provider.transactions.length}",
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: provider.transactions.length,
                    itemBuilder: (context, index) {
                      final transaction =
                          provider.transactions.reversed.toList()[index];

                      final isIncome =
                          transaction.type == "Income";

                      return Card(
                        elevation: 2,
                        margin:
                            const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(12),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    TransactionDetailScreen(
                                  transaction: transaction,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: CircleAvatar(
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
                              ),
                            ),

                            title: Text(
                              transaction.category,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  transaction.note.isEmpty
                                      ? transaction.type
                                      : transaction.note,
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  DateFormat(
                                    "dd MMM yyyy",
                                  ).format(transaction.date),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            trailing: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.end,
                              children: [
                                Text(
                                  CurrencyFormatter.format(
                                      transaction.amount),
                                  style: TextStyle(
                                    color: isIncome
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey.shade500,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}