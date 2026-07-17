// import 'package:flutter/material.dart';

// import '../services/currency_service.dart';

// class CurrencyProvider extends ChangeNotifier {
//   bool isLoading = false;

//   Map<String, dynamic>? data;

//   String? error;

//   Future<void> fetchRates() async {
//     try {
//       isLoading = true;

//       notifyListeners();

//       data = await CurrencyService.getRates();

//       error = null;
//     } catch (e) {
//       error = e.toString();
//     }

//     isLoading = false;

//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';

import '../services/currency_service.dart';

class CurrencyProvider extends ChangeNotifier {
  bool isLoading = false;

  String? error;

  Map<String, double> rates = {};

  Future<void> fetchRates() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final response = await CurrencyService.getRates();

      final rawRates =
          response["rates"] as Map<String, dynamic>;

      rates = rawRates.map(
        (key, value) =>
            MapEntry(key, (value as num).toDouble()),
      );
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}