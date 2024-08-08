import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Paramètres"),
            backgroundColor: Colors.blueGrey,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Fruits", icon: FaIcon(FontAwesomeIcons.appleWhole)),
                Tab(text: "Légumes", icon: FaIcon(FontAwesomeIcons.carrot)),
                Tab(text: "Autres", icon: FaIcon(FontAwesomeIcons.warehouse))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const Text("Fruits"),
              const Text("Légumes"),
              ReorderableListView(
                onReorder: (int oldIndex, int newIndex){
                  setState(() {
                    //TODO
                  });
                },
                children: <Widget>[
                  for(int index = 0; index<5; index ++)
                    ListTile(
                        key: Key("$index"),
                        title: Text("$index"),
                      trailing: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.drag_handle),
                      ),
                    )
                  ],
              )
            ],
          )
      ),
    );
  }

}