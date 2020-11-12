import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aktiMVP/models/http_exception.dart';

import 'ticket_class.dart';

class Tickets with ChangeNotifier {
  List<Ticket> _tickets = [];

  List<Ticket> get tickets {
    return [..._tickets];
  }

  List<Ticket> get favoriteTickets {
    return _tickets.where((indexedTicket) => indexedTicket.isFavorite).toList();
  }

  Ticket findById(String id) {
    return _tickets.firstWhere((indexedTicket) => indexedTicket.id == id);
  }

  Future<void> fetchAndSetTickets() async {
    const url = 'https://my-first-project-de6c8.firebaseio.com/tickets.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Ticket> loadedTickets = [];
      extractedData.forEach((ticketId, ticketData) {
        loadedTickets.add(Ticket(
          id: ticketId,
          title: ticketData['title'],
          description: ticketData['description'],
          discountPrice: ticketData['discountPrice'],
          fullPrice: ticketData['fullPrice'],
          isFavorite: ticketData['isFavorite'],
          imageUrl: ticketData['imageUrl'],
        ));
      });
      _tickets = loadedTickets;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Ticket ticket) async {
    const url = 'https://my-first-project-de6c8.firebaseio.com/tickets.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': ticket.title,
          'description': ticket.description,
          'imageUrl': ticket.imageUrl,
          'fullPrice': ticket.fullPrice,
          'discountPrice': ticket.discountPrice,
          'isFavorite': ticket.isFavorite,
          'numberAvailableTickets': ticket.numberAvailableTickets,
        }),
      );
      final newProduct = Ticket(
        title: ticket.title,
        description: ticket.description,
        fullPrice: ticket.fullPrice,
        imageUrl: ticket.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _tickets.add(newProduct);
      // _tickets.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Ticket newTicket) async {
    final ticketIndex = _tickets.indexWhere((ticket) => ticket.id == id);
    if (ticketIndex >= 0) {
      final url =
          'https://my-first-project-de6c8.firebaseio.com/tickets/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newTicket.title,
            'description': newTicket.description,
            'imageUrl': newTicket.imageUrl,
            'price': newTicket.fullPrice
          }));
      _tickets[ticketIndex] = newTicket;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://my-first-project-de6c8.firebaseio.com/tickets/$id.json';
    final existingTicketIndex =
        _tickets.indexWhere((ticket) => ticket.id == id);
    var existingTicket = _tickets[existingTicketIndex];
    _tickets.removeAt(existingTicketIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _tickets.insert(existingTicketIndex, existingTicket);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingTicket = null;
  }
}
