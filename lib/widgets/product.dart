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

  _decrementCounter(){
    setState(() {
      if(count>0){
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView (
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                widget.title,
                style: const TextStyle(fontSize: 20)
            ),
            const Padding(padding: EdgeInsets.all(2)),
            ElevatedButton(onPressed: _decrementCounter, child: const Text("-1")),
            const Padding(padding: EdgeInsets.all(2)),
            ElevatedButton(onPressed: _incrementCounter, child: const Text("+1")),
            const Padding(padding: EdgeInsets.all(2)),
            Text(
                '$count',
                style: const TextStyle(fontSize: 20)
            )
          ],
        ),
      )
    );
  }
}
