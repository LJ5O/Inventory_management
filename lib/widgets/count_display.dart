import 'package:flutter/material.dart';

class CountDisplay extends StatefulWidget {
  final int count;
  final String unit;
  final Function(int) onCountChanged; // On count edit callback

  const CountDisplay({
    Key? key,
    required this.count,
    required this.unit,
    required this.onCountChanged,
  }) : super(key: key);

  @override
  _CountDisplayState createState() => _CountDisplayState();
}

class _CountDisplayState extends State<CountDisplay> {
  late bool _isEditing;
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _isEditing = false;
    _controller = TextEditingController(text: widget.count.toString());
    _focusNode = FocusNode();

    // Add a listener to detect if input loses focus
    // Is that really useful ? Not so sure, as it seems to be useless
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // If focus is lost, we hide the input and submit the value
        setState(() {
          _isEditing = false;
        });
        _submitValue();
      }
    });
  }

  void _submitValue(){
    int valueToSave = int.tryParse(_controller.text) ?? widget.count;
    widget.onCountChanged(valueToSave); // Callback with new value
    _controller.text = valueToSave.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isEditing
        ? SizedBox(
      width: 60, // Text input size
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        keyboardType: TextInputType.number, // Number keyboard
        onSubmitted: (value) {
          setState(() {
            _isEditing = false;
            _submitValue();
          });
        },
        onEditingComplete: () {
          setState(() {
            _isEditing = false;
            _submitValue();
          });
        },
        autofocus: true, // When clicked, autofocus on input
        textAlign: TextAlign.center,
      ),
    )
        : GestureDetector(
      onTap: () {
        setState(() {
          _isEditing = true;
        });
      },
      child: Text(
        "${widget.count} ${widget.unit}",
        textScaler: const TextScaler.linear(1.2),
      ),
    );
  }
}
