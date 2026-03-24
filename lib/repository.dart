import 'package:flutter/material.dart';
import 'product.dart';

class ProductRepository extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  bool existById(String id) {
    return _products.any((p) => p.id == id);
  }

  void addProduct(Product product) {
    if (existById(product.id)) {
      throw Exception('ID già esistente');
    }

    _products.add(product);
    notifyListeners();
  }
}
