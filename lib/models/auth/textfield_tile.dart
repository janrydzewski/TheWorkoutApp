import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;

  TextFieldWidget({Key? key, required this.title, required this.controller}) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.title,
      ),
    );
  }
}
