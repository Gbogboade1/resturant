import 'package:flutter/material.dart';
import 'package:resturant_video/models/food.dart';

class CartProvider extends ChangeNotifier {
  final List<Food> _items = [];

  List<Food> get items => _items;

  int get totalPrice => _items.length * 42;

  
  void add(Food item) {
    _items.add(item);
    notifyListeners();
  }

  void removeAll() {
    _items.clear();
    notifyListeners();
  }
}
