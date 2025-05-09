import 'package:flutter/material.dart';
import 'package:green_tech_test/Model/picture.dart';

class ArtworkScreen extends StatelessWidget {
  const ArtworkScreen({super.key, required this.artwork});

  final Picture artwork;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artwork.title),),
    );
  }
}
