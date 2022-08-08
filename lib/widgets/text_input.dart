import 'package:flutter/material.dart';


class TextInput extends StatelessWidget {

  final TextEditingController? textEditingController;
  final String? hint;
  const TextInput({
    @required this.textEditingController,
    this.hint,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hint!,
        ),
      ),
    );
  }
}
