import 'package:flutter/material.dart';
import 'package:inventaire/providers/shared_provider.dart';
import 'package:inventaire/widgets/count_display.dart';

class ProductsMarket extends StatefulWidget {
  const ProductsMarket({super.key, required this.productType});

  final String productType;

  @override
  State<StatefulWidget> createState() => _ProductsMarketState();
}

class _ProductsMarketState extends State<ProductsMarket> {
  StorageService storage = StorageService();
  List<String> products = [];
  Map<String, int> productCounts = {};
  Map<String, int> inStockProductsCount = {};
  int lowStockThreshold = 0;
  Map<String, String> units = {};

  @override
  void initState() {
    super.initState();
    _loadProductCounts();  // Charger les quantités au démarrage
  }

  Future<void> _loadProductCounts() async {
    List<String> savedProducts = await storage.getStringList(widget.productType);
    Map<String, int> savedCounts = {};
    Map<String, int> savedStockCounts = {};
    Map<String, String> savedUnits = {};

    for (String product in savedProducts) {
      int count = await storage.getInt('${widget.productType}_${product}_sales');
      savedCounts[product] = count;
      int count2 = await storage.getInt('${widget.productType}_$product');
      savedStockCounts[product] = count2;

      String unit = await storage.getString('${widget.productType}_${product}_unit') ?? ""; // Valid value or ""
      savedUnits[product] = unit=="" ? 'Unités' : unit;// Default if value is ""
    }

    int lowStockThreshold = await storage.getInt("low_stock_threshold");

    setState(() {
      products = savedProducts;
      productCounts = savedCounts;
      inStockProductsCount = savedStockCounts;
      this.lowStockThreshold = lowStockThreshold;
      units = savedUnits;
    });
  }

  int _getItemCount(String item) {
    return productCounts[item] ?? 0;
  }

  String _getItemUnit(String item) {
    return units[item] ?? 'Unités';
  }

  int _getStockItemCount(String item) {
    return inStockProductsCount[item] ?? 0;
  }

  Future<void> _addOneItemCount(String item) async {
    setState(() {
      productCounts[item] = (productCounts[item] ?? 0) + 1;
    });
    await storage.setInt('${widget.productType}_${item}_sales', productCounts[item]!);
  }

  Future<void> _setItemCount(String item, int count) async {
    print("PING $count");
    setState(() {
      productCounts[item] = count;
    });
    await storage.setInt('${widget.productType}_${item}_sales', productCounts[item]!);
  }

  Future<void> _removeOneItemCount(String item) async {
    setState(() {
      if (productCounts[item] != null && productCounts[item]! > 0) {
        productCounts[item] = productCounts[item]! - 1;
      }
    });
    await storage.setInt('${widget.productType}_${item}_sales', productCounts[item]!);
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
        int numberOfItemsStillInStock = _getStockItemCount(product) - count;
        String unit = _getItemUnit(product);

        return ListTile(
          key: Key(product),
          title: Text(
            product,
            textScaler: const TextScaler.linear(0.9),
          ),
          tileColor: index.isOdd ? oddItemColor : evenItemColor,
          leading: CountDisplay(
              count: count,
              unit: unit,
              onCountChanged: (int value)=>_setItemCount(product, value)
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
          subtitle: numberOfItemsStillInStock<=lowStockThreshold ?
            Text("Il n'y a plus que $numberOfItemsStillInStock $unit en stock !", style:const TextStyle(color: Colors.red)) :
            Text("Il reste $numberOfItemsStillInStock $unit en stock."),
        );
      },
    );
  }
}
