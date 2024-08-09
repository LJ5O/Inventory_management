import 'package:flutter/material.dart';
import 'package:inventaire/providers/shared_provider.dart';

class ProductsViewer extends StatefulWidget {
  const ProductsViewer({super.key, required this.productType});

  final String productType;

  @override
  State<StatefulWidget> createState() => _ProductsViewerState();
}

class _ProductsViewerState extends State<ProductsViewer> {
  StorageService storage = StorageService();
  List<String> products = [];
  Map<String, int> productCounts = {};

  @override
  void initState() {
    super.initState();
    _loadProductCounts();  // Charger les quantités au démarrage
  }

  Future<void> _loadProductCounts() async {
    List<String> savedProducts = await storage.getStringList(widget.productType);
    Map<String, int> savedCounts = {};

    for (String product in savedProducts) {
      int count = await storage.getInt('${widget.productType}_$product');
      savedCounts[product] = count;
    }

    setState(() {
      products = savedProducts;
      productCounts = savedCounts;
    });
  }

  int _getItemCount(String item) {
    return productCounts[item] ?? 0;
  }

  Future<void> _addOneItemCount(String item) async {
    setState(() {
      productCounts[item] = (productCounts[item] ?? 0) + 1;
    });
    await storage.setInt('${widget.productType}_$item', productCounts[item]!);
  }

  Future<void> _removeOneItemCount(String item) async {
    setState(() {
      if (productCounts[item] != null && productCounts[item]! > 0) {
        productCounts[item] = productCounts[item]! - 1;
      }
    });
    await storage.setInt('${widget.productType}_$item', productCounts[item]!);
  }

  @override
  Widget build(BuildContext context) {
    if (!["vegetables", "fruits", "others"].contains(widget.productType)) {
      throw AssertionError('Product Type should be "vegetables", "fruits" or "others"!');
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);

    return products.isEmpty
        ? const Center(child: Text("Aucun élément n'est dans cette liste."))
        : ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
        String product = products[index];
        int count = _getItemCount(product);

        return ListTile(
          key: Key(product),
          title: Text(
            product,
            textScaler: const TextScaler.linear(1.3),
          ),
          tileColor: index.isOdd ? oddItemColor : evenItemColor,
          leading: Text(
            "$count",
            textScaler: const TextScaler.linear(1.8),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => _addOneItemCount(product),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Icon(Icons.add, color: Colors.white,),
              ),
              const Padding(padding: EdgeInsets.all(2)),
              ElevatedButton(
                onPressed: () => _removeOneItemCount(product),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Icon(Icons.remove, color:Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
