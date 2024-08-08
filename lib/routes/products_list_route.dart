
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventaire/routes/settings_route.dart';

import '../widgets/product.dart';

class ProductsListRoute extends StatefulWidget {
  const ProductsListRoute({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
          body: TabBarView(
            children: [SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    ProductWidget(
                      title: "Pomme",
                    ),
                  ],
                )
            ),
              SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      ProductWidget(
                        title: "Carrote",
                      ),
                    ],
                  )
              ),
              SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const <Widget>[
                      ProductWidget(
                        title: "Champignons",
                      ),
                    ],
                  )
              )],
          )
      ),
    );
  }
}
