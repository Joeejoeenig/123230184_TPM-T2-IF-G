// import 'package:flutter/material.dart';

// class CurrencyScreen extends StatelessWidget {
//   const CurrencyScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Currency Converter"),
//       ),
//       body: const Center(
//         child: Text(
//           "Currency Converter",
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/currency_provider.dart';

// class CurrencyScreen extends StatefulWidget {
//   const CurrencyScreen({super.key});

//   @override
//   State<CurrencyScreen> createState() => _CurrencyScreenState();
// }

// class _CurrencyScreenState extends State<CurrencyScreen> {
//   final TextEditingController amountController =
//       TextEditingController(text: "100000");

//   final List<String> currencies = [
//     "USD",
//     "EUR",
//     "JPY",
//     "SGD",
//     "MYR",
//     "GBP",
//     "AUD",
//   ];

//   String selectedCurrency = "USD";

//   double result = 0;

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       context.read<CurrencyProvider>().fetchRates();
//     });
//   }

//   void convert(CurrencyProvider provider) {
//     if (provider.data == null) return;

//     final amount =
//         double.tryParse(amountController.text) ?? 0;

//     final rates =
//         provider.data!["rates"] as Map<String, dynamic>;

//     final rate =
//         (rates[selectedCurrency] as num).toDouble();

//     setState(() {
//       result = amount * rate;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<CurrencyProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Currency Converter"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               provider.fetchRates();
//             },
//             icon: const Icon(Icons.refresh),
//           )
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: provider.isLoading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : provider.error != null
//                 ? Center(
//                     child: Text(provider.error!),
//                   )
//                 : Column(
//                     crossAxisAlignment:
//                         CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Amount (IDR)",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 8),

//                       TextField(
//                         controller: amountController,
//                         keyboardType:
//                             TextInputType.number,
//                         decoration: InputDecoration(
//                           border:
//                               OutlineInputBorder(),
//                           prefixText: "Rp ",
//                         ),
//                       ),

//                       const SizedBox(height: 20),

//                       const Text(
//                         "Convert To",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),

//                       const SizedBox(height: 8),

//                       DropdownButtonFormField<String>(
//                         value: selectedCurrency,
//                         decoration:
//                             const InputDecoration(
//                           border:
//                               OutlineInputBorder(),
//                         ),
//                         items: currencies
//                             .map(
//                               (e) => DropdownMenuItem(
//                                 value: e,
//                                 child: Text(e),
//                               ),
//                             )
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedCurrency =
//                                 value!;
//                           });
//                         },
//                       ),

//                       const SizedBox(height: 25),

//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: () {
//                             convert(provider);
//                           },
//                           icon:
//                               const Icon(Icons.currency_exchange),
//                           label: const Text(
//                             "Convert",
//                           ),
//                         ),
//                       ),

//                       const SizedBox(height: 30),

//                       if (provider.data != null)
//                         Card(
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.all(20),
//                             child: Column(
//                               children: [
//                                 Text(
//                                   "1 IDR = ${provider.data!["rates"][selectedCurrency]} $selectedCurrency",
//                                   style:
//                                       const TextStyle(
//                                     fontSize: 16,
//                                   ),
//                                 ),

//                                 const SizedBox(
//                                   height: 20,
//                                 ),

//                                 Text(
//                                   "${amountController.text} IDR",
//                                   style:
//                                       const TextStyle(
//                                     fontSize: 18,
//                                   ),
//                                 ),

//                                 const Icon(
//                                   Icons.arrow_downward,
//                                 ),

//                                 Text(
//                                   "${result.toStringAsFixed(2)} $selectedCurrency",
//                                   style:
//                                       const TextStyle(
//                                     fontSize: 30,
//                                     fontWeight:
//                                         FontWeight.bold,
//                                     color: Colors.blue,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/currency_provider.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final TextEditingController amountController =
      TextEditingController(text: "100000");

  final List<String> currencies = [
    "USD",
    "EUR",
    "JPY",
    "SGD",
    "MYR",
    "GBP",
    "AUD",
  ];

  String selectedCurrency = "USD";

  double result = 0;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CurrencyProvider>().fetchRates();
    });
  }

  void convert() {
    final provider = context.read<CurrencyProvider>();

    if (!provider.rates.containsKey(selectedCurrency)) {
      return;
    }

    final amount =
        double.tryParse(amountController.text) ?? 0;

    final rate = provider.rates[selectedCurrency]!;

    setState(() {
      result = amount * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CurrencyProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Currency Converter"),
        actions: [
          IconButton(
            onPressed: provider.fetchRates,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: provider.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : provider.error != null
                ? Center(
                    child: Text(provider.error!),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Amount (IDR)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        TextField(
                          controller: amountController,
                          keyboardType:
                              TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "Rp ",
                            border: OutlineInputBorder(),
                          ),
                        ),

                        const SizedBox(height: 20),

                        DropdownButtonFormField<String>(
                          value: selectedCurrency,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Currency",
                          ),
                          items: currencies
                              .map(
                                (currency) =>
                                    DropdownMenuItem(
                                  value: currency,
                                  child: Text(currency),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCurrency = value!;
                            });
                          },
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: convert,
                            child:
                                const Text("Convert"),
                          ),
                        ),

                        const SizedBox(height: 30),

                        if (provider.rates.isNotEmpty)
                          Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    "1 IDR = ${provider.rates[selectedCurrency]} $selectedCurrency",
                                  ),

                                  const SizedBox(height: 20),

                                  Text(
                                    "${amountController.text} IDR",
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  const Icon(
                                    Icons.arrow_downward,
                                  ),

                                  const SizedBox(height: 10),

                                  Text(
                                    "${result.toStringAsFixed(2)} $selectedCurrency",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
      ),
    );
  }
}