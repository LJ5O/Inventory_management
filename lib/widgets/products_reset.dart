import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../providers/shared_provider.dart';

class ProductsReset extends StatelessWidget{
  const ProductsReset({super.key});

  Future<void> resetSalesProducts(bool removeFromInventory) async {
    //This function is used to reset all counters in sales route
    StorageService storage = StorageService();
    for (var type in ["fruits", "vegetables", "others"]) {
      List<String> savedProducts = await storage.getStringList(type);
      for (var element in savedProducts) {
        if(removeFromInventory){
          int inInventory = await storage.getInt('${type}_$element');
          int soldElements = await storage.getInt('${type}_${element}_sales');
          storage.setInt('${type}_$element', inInventory-soldElements);
        }
        storage.setInt('${type}_${element}_sales', 0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text("Ce bouton permet de remettre tous les compteurs du marché à 0, et retirera les valeurs de ce qu'il reste en stock.", textAlign: TextAlign.center),
        ElevatedButton(
            onPressed: (){resetSalesProducts(true);},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Remettre les ventes à zéro, et retirer cela du stock", style: TextStyle(color: Colors.white))
        ),
        const Padding(padding: EdgeInsets.all(20.0)),
        const Text("Ce bouton va remettre tous les compteurs du marché à 0, SANS retirer les valeurs du stock.", textAlign: TextAlign.center),
        ElevatedButton(
            onPressed: (){resetSalesProducts(false);},
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text("Remettre les ventes à zéro, sans retirer du stock", style: TextStyle(color: Colors.white))
        )
      ],
    );
  }
  
}