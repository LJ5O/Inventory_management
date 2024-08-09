
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventaire/routes/settings_route.dart';
import 'package:inventaire/widgets/products_viewer.dart';

class ProductsListRoute extends StatefulWidget {
  const ProductsListRoute({super.key, required this.title});

  final String title;

  @override
  State<ProductsListRoute> createState() => _ProductsListRouteState();
}

class _ProductsListRouteState extends State<ProductsListRoute> {

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            backgroundColor: Colors.green,
            actions: [
              IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: "Paramètres de l'application",
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingsRoute() ));
                  }
              )
            ],
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
              ProductsViewer(productType: "fruits"),
              ProductsViewer(productType: "vegetables"),
              ProductsViewer(productType: "others"),
              ],
          )
      )
    );
  }
}
