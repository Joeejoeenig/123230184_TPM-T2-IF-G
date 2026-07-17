// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/transaction_provider.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<TransactionProvider>();

//     final recentTransactions =
//         provider.transactions.reversed.take(5).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Smart Expense Tracker"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Welcome 👋",
//               style: TextStyle(
//                 fontSize: 18,
//                 color: Colors.grey,
//               ),
//             ),

//             const SizedBox(height: 8),

//             const Text(
//               "Total Balance",
//               style: TextStyle(fontSize: 18),
//             ),

//             const SizedBox(height: 10),

//             Card(
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   children: [
//                     Text(
//                       "Rp ${provider.balance.toStringAsFixed(0)}",
//                       style: const TextStyle(
//                         fontSize: 34,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     const SizedBox(height: 15),

//                     Row(
//                       mainAxisAlignment:
//                           MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Column(
//                           children: [
//                             const Icon(
//                               Icons.arrow_downward,
//                               color: Colors.green,
//                             ),
//                             const SizedBox(height: 5),
//                             const Text("Income"),
//                             Text(
//                               "Rp ${provider.totalIncome.toStringAsFixed(0)}",
//                               style: const TextStyle(
//                                 color: Colors.green,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),

//                         Column(
//                           children: [
//                             const Icon(
//                               Icons.arrow_upward,
//                               color: Colors.red,
//                             ),
//                             const SizedBox(height: 5),
//                             const Text("Expense"),
//                             Text(
//                               "Rp ${provider.totalExpense.toStringAsFixed(0)}",
//                               style: const TextStyle(
//                                 color: Colors.red,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             const Text(
//               "Recent Transactions",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 15),

//             if (recentTransactions.isEmpty)
//               const Card(
//                 child: ListTile(
//                   title: Text("No transaction yet"),
//                   subtitle:
//                       Text("Start adding your first transaction"),
//                 ),
//               )
//             else
//               ListView.builder(
//                 shrinkWrap: true,
//                 physics:
//                     const NeverScrollableScrollPhysics(),
//                 itemCount: recentTransactions.length,
//                 itemBuilder: (context, index) {
//                   final transaction =
//                       recentTransactions[index];

//                   final isIncome =
//                       transaction.type == "Income";

//                   return Card(
//                     margin:
//                         const EdgeInsets.only(bottom: 10),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: isIncome
//                             ? Colors.green.shade100
//                             : Colors.red.shade100,
//                         child: Icon(
//                           isIncome
//                               ? Icons.arrow_downward
//                               : Icons.arrow_upward,
//                           color: isIncome
//                               ? Colors.green
//                               : Colors.red,
//                         ),
//                       ),
//                       title: Text(transaction.category),
//                       subtitle: Text(
//                         transaction.note.isEmpty
//                             ? transaction.type
//                             : transaction.note,
//                       ),
//                       trailing: Text(
//                         "Rp ${transaction.amount.toStringAsFixed(0)}",
//                         style: TextStyle(
//                           color: isIncome
//                               ? Colors.green
//                               : Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/transaction_provider.dart';
import '../utils/currency_formatter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    final recentTransactions =
        provider.transactions.reversed.take(5).toList();

    final incomeCount = provider.transactions
        .where((e) => e.type == "Income")
        .length;

    final expenseCount = provider.transactions
        .where((e) => e.type == "Expense")
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Expense Tracker"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome 👋",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const Text(
              "Manage your expenses wisely",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      CurrencyFormatter.format(provider.balance),
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.arrow_downward,
                              color: Colors.green,
                            ),
                            const SizedBox(height: 5),
                            const Text("Income"),
                            Text(
                              CurrencyFormatter.format(
                                  provider.totalIncome),
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          children: [
                            const Icon(
                              Icons.arrow_upward,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 5),
                            const Text("Expense"),
                            Text(
                              CurrencyFormatter.format(
                                  provider.totalExpense),
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Income",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("$incomeCount"),
                      ],
                    ),

                    Column(
                      children: [
                        const Text(
                          "Expense",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("$expenseCount"),
                      ],
                    ),

                    Column(
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            "${provider.transactions.length}"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            if (recentTransactions.isEmpty)
              const Card(
                child: ListTile(
                  title: Text("No transaction yet"),
                  subtitle: Text(
                    "Start adding your first transaction",
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(),
                itemCount: recentTransactions.length,
                itemBuilder: (context, index) {
                  final transaction =
                      recentTransactions[index];

                  final isIncome =
                      transaction.type == "Income";

                  return Card(
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
                      title: Text(transaction.category),
                      subtitle: Text(
                        transaction.note.isEmpty
                            ? transaction.type
                            : transaction.note,
                      ),
                      trailing: Text(
                        CurrencyFormatter.format(
                            transaction.amount),
                        style: TextStyle(
                          color: isIncome
                              ? Colors.green
                              : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}