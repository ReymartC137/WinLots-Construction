import 'package:flutter/material.dart';

class DropDownText extends StatelessWidget {

  final List<String>? dropList;
  const DropDownText({
    @required this.dropList,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownButton<String>(
        isExpanded: true,

        hint: Text(dropList![0]),
        items: <String>[dropList![0],dropList![1],dropList![2],dropList![3]].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      ),
    );
  }
}
