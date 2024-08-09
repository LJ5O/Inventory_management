import 'package:flutter/material.dart';
import 'package:inventaire/routes/products_list_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion du stock',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ProductsListRoute(title: 'Légumes de Brouckerque'),
    );
  }
}