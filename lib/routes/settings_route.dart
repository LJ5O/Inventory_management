import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventaire/widgets/app_settings.dart';
import 'package:inventaire/widgets/products_editor.dart';

class SettingsRoute extends StatefulWidget{
  const SettingsRoute({super.key});

  @override
  State<SettingsRoute> createState() => _SettingsRouteState();

}

class _SettingsRouteState extends State<SettingsRoute> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Paramètres"),
            backgroundColor: Colors.blueGrey,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Fruits", icon: FaIcon(FontAwesomeIcons.appleWhole)),
                Tab(text: "Légumes", icon: FaIcon(FontAwesomeIcons.carrot)),
                Tab(text: "Autres", icon: FaIcon(FontAwesomeIcons.warehouse)),
                Tab(text: "Gérer", icon: FaIcon(FontAwesomeIcons.wrench),)
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              ProductsEditor(
                productType: "fruits"
              ),
              ProductsEditor(
                  productType: "vegetables"
              ),
              ProductsEditor(
                  productType: "others"
              ),
              AppSettings()
            ],
          )
      ),
    );
  }

}