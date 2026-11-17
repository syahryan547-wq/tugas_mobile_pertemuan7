import 'package:flutter/material.dart';

class Product {
  final String nama;
  final String gambar;

  Product(this.nama, this.gambar);
}

class CartModel extends ChangeNotifier {
  final List<Product> _item = [];

  List<Product> get items => _item;
  int get totalItems => _item.length;

  void add(Product product) {
    _item.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _item.remove(product);
    notifyListeners();
  }
}