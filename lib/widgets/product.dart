import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _ProductState();

}

class _ProductState extends State<ProductWidget>{
  int count = 0;

  _incrementCounter(){
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(fontSize: 20)
          ),
          const Padding(padding: EdgeInsets.all(2)),
          ElevatedButton(onPressed: _incrementCounter, child: const Text("-1")),
          const Padding(padding: EdgeInsets.all(2)),
          ElevatedButton(onPressed: _incrementCounter, child: const Text("+1")),
          const Padding(padding: EdgeInsets.all(2)),
          Text(
              '$count',
              style: TextStyle(fontSize: 20)
          )
        ],
      )
    );
  }
}
