import 'dart:convert';

import 'package:e_shop/others/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.description,
    required this.imageUrl,
    required this.title,
    required this.price,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token, String uid) async {
    _toggleFavorite();
    try {
      final response = await http.put(
          Uri.parse(
              '${Constants.USER_FAVORITES_URL}/$uid/$id.json?auth=$token'),
          body: jsonEncode({"isFavorite": isFavorite}));
      if (response.statusCode >= 400) {
        _toggleFavorite();
        notifyListeners();
      }
    } catch (_) {
      _toggleFavorite();
    }
  }
}
