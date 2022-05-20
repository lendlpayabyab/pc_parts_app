import 'package:flutter/material.dart';
import 'package:pc_parts_app/models/models.dart';

class CartManager extends ChangeNotifier {
  final _cartItems = <CartItem>[];
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  void deleteItem(int index){
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void addItem(CartItem item){
    _cartItems.add(item);
    notifyListeners();
  }

  void updateItem(CartItem item, int index){
    _cartItems[index] = item;
    notifyListeners();
  }

}