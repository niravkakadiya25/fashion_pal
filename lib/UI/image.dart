import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullImage extends StatefulWidget {
  final String imageUrl;
  const FullImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  _FullImageState createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
