//Shared preference rules
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Store {
  //Salva String
  static Future<bool> saveString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  //Salva Map
  static Future<void> saveMap(String key, Map<String, dynamic> value) async {
    saveString(key, jsonEncode(value));
  }

  //Lê uma String que foi persistida
  static Future<String> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  //Lê um map que foi persistido
  static Future<Map<String, dynamic>> getMap(String key) async {
    try {
      return jsonDecode(await getString(key));
    } catch (_) {
      return {};
    }
  }

  //Remove valor da chave
  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
