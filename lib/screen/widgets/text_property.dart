import 'package:flutter/material.dart';

class TextProperty extends StatelessWidget {
  const TextProperty(
      {Key? key,
      required this.title,
      required this.value,
      required this.height})
      : super(key: key);

  final String title;
  final double height;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'SFRegular',
              fontSize: 18,
            ),
          ),
        )
      ],
    );
  }
}
