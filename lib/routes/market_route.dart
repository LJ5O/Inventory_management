import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventaire/widgets/products_reset.dart';
import 'package:inventaire/widgets/products_sales.dart';

class MarketRoute extends StatefulWidget{
  const MarketRoute({super.key});

  @override
  State<MarketRoute> createState() => _MarketRouteState();

}

class _MarketRouteState extends State<MarketRoute> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Marché"),
            backgroundColor: Colors.blueAccent,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Fruits", icon: FaIcon(FontAwesomeIcons.appleWhole)),
                Tab(text: "Légumes", icon: FaIcon(FontAwesomeIcons.carrot)),
                Tab(text: "Autres", icon: FaIcon(FontAwesomeIcons.warehouse)),
                Tab(text: "Gérer", icon: FaIcon(FontAwesomeIcons.wrench))
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ProductsMarket(
                productType: "fruits"
              ),
              ProductsMarket(
                  productType: "vegetables"
              ),
              ProductsMarket(
                  productType: "others"
              ),
              ProductsReset()
            ],
          )
      ),
    );
  }

}