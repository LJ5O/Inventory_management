import 'dart:ffi';

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

  void _updateProductList(int oldIndex, int newIndex, List<String> products) async {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final String item = products.removeAt(oldIndex);
      products.insert(newIndex, item);
    });

    // Appel asynchrone en dehors de setState
    await storage.setStringList(widget.productType, products);
  }

  @override
  Widget build(BuildContext context) {

    if(!["vegetables", "fruits", "others"].contains(widget.productType)){
      throw AssertionError('Product Type should be "vegetables", "fruits" or "others" !');
    }

    return FutureBuilder(
      future: storage.getStringList(widget.productType),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot){
        List<String> products = ["Cerise", "Fraise", "Framboise", "Pomme"] ?? snapshot.data ?? [];
        if(products.isEmpty){//No products
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Aucun élément n'est dans cette liste."),
                ElevatedButton(onPressed: null, child: Text("Ajouter"))
              ],
            )
          );
        }else{
          return ReorderableListView(
            onReorder: (int oldIndex, int newIndex){
              _updateProductList(oldIndex, newIndex, products);
            },
            children: <Widget>[
              for(int index = 0; index<products.length; index ++)
                ListTile(
                  key: Key(products[index]),
                  title: Text(products[index]),
                  tileColor: index%2==0 ? Colors.white : Colors.white10,
                  trailing: ReorderableDragStartListener(
                    index: index,
                    child: const Icon(Icons.drag_handle),
                  ),
                )
            ],
          );
        }
      }
    );
  }
}
