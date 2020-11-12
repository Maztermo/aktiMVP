import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Ticket with ChangeNotifier {
  final String id;
  final String companyName;
  final String title;
  final String description;
  final String imageUrl;
  final int fullPrice;
  final int discountPrice;
  final int numberAvailableTickets;
  bool isFavorite;

  Ticket({
    this.id,
    this.companyName,
    this.title,
    this.description,
    this.imageUrl,
    this.fullPrice,
    this.discountPrice,
    this.numberAvailableTickets,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://my-first-project-de6c8.firebaseio.com/products/$id.json';
    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
