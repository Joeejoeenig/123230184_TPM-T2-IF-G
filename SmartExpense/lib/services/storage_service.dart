import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String transactionKey = "transactions";

  static Future<SharedPreferences> prefs() async {
    return await SharedPreferences.getInstance();
  }
}