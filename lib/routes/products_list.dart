
import 'package:flutter/material.dart';

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

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                ProductWidget(
                  title: "Tomates",
                ),
                ProductWidget(
                  title: "Tomates ( grosse )",
                ),
                ProductWidget(
                  title: "Tomates ( Petite rouge )",
                ),
                ProductWidget(
                  title: "Melons",
                ),
                ProductWidget(
                  title: "Courgettes",
                ),
                ProductWidget(
                  title: "Fraises",
                ),
                ProductWidget(
                  title: "Framboises",
                ),
                ProductWidget(
                  title: "Cerises",
                ),
                ProductWidget(
                  title: "Oranges",
                ),
                ProductWidget(
                  title: "Télévisions Ultra HD 4K",
                ),
                ProductWidget(
                  title: "Citrouilles",
                ),
                ProductWidget(
                  title: "TEST",
                ),
              ],
            )
        )
    );
  }
}
