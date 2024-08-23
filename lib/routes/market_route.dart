import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventaire/widgets/products_editor.dart';
import 'package:inventaire/widgets/products_viewer.dart';

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
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Marché"),
            backgroundColor: Colors.blueAccent,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Fruits", icon: FaIcon(FontAwesomeIcons.appleWhole)),
                Tab(text: "Légumes", icon: FaIcon(FontAwesomeIcons.carrot)),
                Tab(text: "Autres", icon: FaIcon(FontAwesomeIcons.warehouse))
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ProductsViewer(
                productType: "fruits"
              ),
              ProductsViewer(
                  productType: "vegetables"
              ),
              ProductsViewer(
                  productType: "others"
              )
            ],
          )
      ),
    );
  }

}