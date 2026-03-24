import 'package:flutter/material.dart';
import 'package:flutter_navigation/product.dart';

void main() {
  runApp(const MyApp ());  //ProductSummaryPage
}

class myApp extends StatelessWidget{
  const myApp({super.key});

  @override 
  Widget build(BuildContext context){
    return MaterialApp.router(
      title: 'Product Registration',
      routerConfig: _router,
    );

  
  
  
  }





final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/product-form',
      builder: (context, state) => const ProductFormPage(),
      ),
      GoRoute(
        path: 'product-summary',
        builder: (context, state){
          final product = state.extra as Product?;
          return ProductSummaryPage(product: product)
        },
      ),
  ],
  initialLocation: '/product-form',
);