import 'dart:convert';

import 'package:http/http.dart' as http;

class CurrencyService {
  static Future<Map<String, dynamic>> getRates() async {
    final response = await http.get(
      Uri.parse(
        "https://api.frankfurter.app/latest?from=IDR",
        //"https://api.frankfurter.app/latest?base=IDR",
      ),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Failed to load exchange rates");
  }
}