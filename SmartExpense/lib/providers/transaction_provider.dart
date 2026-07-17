// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../models/transaction_model.dart';

// class TransactionProvider extends ChangeNotifier {
//   final List<TransactionModel> _transactions = [];

//   List<TransactionModel> get transactions => _transactions;

//   TransactionProvider() {
//     loadTransactions();
//   }

//   double get totalIncome {
//     return _transactions
//         .where((e) => e.type == "Income")
//         .fold(0, (sum, e) => sum + e.amount);
//   }

//   double get totalExpense {
//     return _transactions
//         .where((e) => e.type == "Expense")
//         .fold(0, (sum, e) => sum + e.amount);
//   }

//   double get balance {
//     return totalIncome - totalExpense;
//   }

//   Future<void> addTransaction(TransactionModel transaction) async {
//     _transactions.add(transaction);

//     await saveTransactions();

//     notifyListeners();
//   }

//   Future<void> saveTransactions() async {
//     final prefs = await SharedPreferences.getInstance();

//     final data = _transactions
//         .map((e) => jsonEncode(e.toMap()))
//         .toList();

//     await prefs.setStringList("transactions", data);
//   }

//   Future<void> loadTransactions() async {
//     final prefs = await SharedPreferences.getInstance();

//     final data = prefs.getStringList("transactions");

//     if (data != null) {
//       _transactions.clear();

//       _transactions.addAll(
//         data.map(
//           (e) => TransactionModel.fromMap(
//             jsonDecode(e),
//           ),
//         ),
//       );

//       notifyListeners();
//     }
//   }
// }

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  TransactionProvider() {
    loadTransactions();
  }

  double get totalIncome => _transactions
      .where((e) => e.type == "Income")
      .fold(0.0, (sum, e) => sum + e.amount);

  double get totalExpense => _transactions
      .where((e) => e.type == "Expense")
      .fold(0.0, (sum, e) => sum + e.amount);

  double get balance => totalIncome - totalExpense;

  Future<void> addTransaction(TransactionModel transaction) async {
    _transactions.add(transaction);

    await saveTransactions();

    notifyListeners();
  }

  Future<void> updateTransaction(String id, TransactionModel updatedTransaction,) async {
    final index =
    _transactions.indexWhere((e) => e.id == id);
    
    if (index == -1) return;
    
    _transactions[index] = updatedTransaction;
    
    await saveTransactions();
    
    notifyListeners();}
  
  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((e) => e.id == id);
    
    await saveTransactions();
    
    notifyListeners();}

  Future<void> saveTransactions() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList =
        _transactions.map((e) => jsonEncode(e.toMap())).toList();

    await prefs.setStringList("transactions", jsonList);
  }

  Future<void> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList("transactions");

    if (jsonList == null) return;

    _transactions.clear();

    _transactions.addAll(
      jsonList.map(
        (e) => TransactionModel.fromMap(jsonDecode(e)),
      ),
    );

    notifyListeners();
  }
}