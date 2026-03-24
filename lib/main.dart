import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'product.dart';
import 'repository.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProductRepository(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Product Registration',
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/product-form',
  routes: [
    GoRoute(
      path: '/product-form',
      builder: (context, state) => const ProductFormPage(),
    ),
    GoRoute(
      path: '/product-summary',
      builder: (context, state) {
        return const ProductSummaryPage();
      },
    ),
  ],
);
