// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/transaction_provider.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<TransactionProvider>();

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
//               style: TextStyle(
//                 fontSize: 18,
//               ),
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
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

//             if (provider.transactions.isEmpty)
//               const Card(
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     child: Icon(Icons.fastfood),
//                   ),
//                   title: Text("No transaction yet"),
//                   subtitle: Text("Start adding your first transaction"),
//                 ),
//               )
//             else
//               Card(
//                 child: ListTile(
//                   leading: CircleAvatar(
//                     child: Icon(
//                       provider.transactions.last.type == "Income"
//                           ? Icons.arrow_downward
//                           : Icons.arrow_upward,
//                     ),
//                   ),
//                   title: Text(provider.transactions.last.category),
//                   subtitle: Text(
//                     provider.transactions.last.note.isEmpty
//                         ? provider.transactions.last.type
//                         : provider.transactions.last.note,
//                   ),
//                   trailing: Text(
//                     "Rp ${provider.transactions.last.amount.toStringAsFixed(0)}",
//                     style: TextStyle(
//                       color: provider.transactions.last.type == "Income"
//                           ? Colors.green
//                           : Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
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

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TransactionProvider>();

    final recentTransactions =
        provider.transactions.reversed.take(5).toList();

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
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Total Balance",
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "Rp ${provider.balance.toStringAsFixed(0)}",
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

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
                              "Rp ${provider.totalIncome.toStringAsFixed(0)}",
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
                              "Rp ${provider.totalExpense.toStringAsFixed(0)}",
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
                  subtitle:
                      Text("Start adding your first transaction"),
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
                    margin:
                        const EdgeInsets.only(bottom: 10),
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
                        "Rp ${transaction.amount.toStringAsFixed(0)}",
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