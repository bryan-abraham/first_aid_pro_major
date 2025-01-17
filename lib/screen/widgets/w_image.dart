import 'dart:io';

import 'package:flutter/material.dart';

class WoundImage extends StatelessWidget {
  const WoundImage({Key? key, required this.size, required this.imageFile})
      : super(key: key);

  final Size size;
  final File imageFile;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.width * 0.3,
      backgroundImage: Image.file(
        imageFile,
        fit: BoxFit.cover,
      ).image,
    );
  }
}
