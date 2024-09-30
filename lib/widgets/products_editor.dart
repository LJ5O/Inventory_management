import 'package:flutter/material.dart';
import 'package:inventaire/providers/shared_provider.dart';

class ProductsEditor extends StatefulWidget {
  const ProductsEditor({super.key, required this.productType});

  final String productType;

  @override
  State<StatefulWidget> createState() => _ProductsEditorState();

}

class _ProductsEditorState extends State<ProductsEditor>{

  StorageService storage = StorageService();
  List<String> products = [];

  void _updateProductList(int oldIndex, int newIndex, List<String> products) async {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final String item = products.removeAt(oldIndex);
      products.insert(newIndex, item);
    });

    // Saving the new list behind the scenes
    await storage.setStringList(widget.productType, products);
  }

  void _sortProductsAlphabetically(List<String> products) async {
    setState(() {
      products.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    });

    // Save sorted list
    await storage.setStringList(widget.productType, products);
  }

  void _addProduct(String productName, List<String> products) async {
    setState(() {
      products.insert(0, productName);
    });
    // Saving the new list behind the scenes
    await storage.setStringList(widget.productType, products);
  }

  void _removeProduct(int index, List<String> products) async {
    setState(() {
      products.removeAt(index);
    });
    // Saving the new list behind the scenes
    await storage.setStringList(widget.productType, products);
  }

  void _showAddProductDialog(BuildContext context) {
    String productName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Ajouter un produit"),
          content: TextField(
            onChanged: (value) {
              productName = value.trim();
            },
            decoration: const InputDecoration(
              hintText: "Nom du produit",
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close, do nothing
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () {
                if(productName!=""){
                  _addProduct(productName, products);
                }
                Navigator.of(context).pop(); // Fermer la popup
              },
              child: const Text("Ajouter"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    if(!["vegetables", "fruits", "others"].contains(widget.productType)){
      throw AssertionError('Product Type should be "vegetables", "fruits" or "others" !');
    }

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.secondary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.secondary.withOpacity(0.15);

    return FutureBuilder(
      future: storage.getStringList(widget.productType),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
        products = snapshot.data ?? [];
        if(products.isEmpty){//No products
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Aucun élément n'est dans cette liste."),
                ElevatedButton(
                    onPressed: (){_showAddProductDialog(context);},
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Ajouter", style: TextStyle(color: Colors.white)),
                )
              ],
            )
          );
        }else{
          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  _showAddProductDialog(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Ajouter un produit", style: TextStyle(color: Colors.white))
              ),
              Expanded(
                child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    _updateProductList(oldIndex, newIndex, products);
                  },
                  children: <Widget>[
                    for (int index = 0; index < products.length; index++)
                      ListTile(
                        key: Key(products[index]),
                        title: Text(products[index]),
                        tileColor: index.isOdd ? oddItemColor : evenItemColor,
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_handle),
                        ),
                        leading: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: (){_removeProduct(index, products);},
                          child: const Icon(Icons.delete_forever, color: Colors.white,)
                        ),
                      ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: (){_sortProductsAlphabetically(products);},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: const Text("Tri alphabétique", style: TextStyle(color: Colors.white),)
              )
            ],
          );
        }
      }
    );
  }
}
