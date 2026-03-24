import 'package:flutter/material.dart';
import 'package:flutter_navigation/product.dart';

class ProductRepository extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.unmodifiable(_products);

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
