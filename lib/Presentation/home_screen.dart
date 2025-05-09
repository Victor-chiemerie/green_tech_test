import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_tech_test/Model/pictures.dart';
import 'package:green_tech_test/Presentation/artwork_screen.dart';

import '../Model/picture.dart';
import 'Themes/textThemes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Picture> artworks = pictureList;
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final height = constraints.maxHeight;
          final width = constraints.maxWidth;
          return SizedBox(
            height: height,
            child: Padding(
              padding: EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 15),
              child: ListView.builder(
                itemCount: artworks.length,
                itemBuilder: (context, index) {
                  final artwork = artworks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          // show full art detail
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) => ArtworkScreen(artwork: artwork),
                            ),
                          );
                        },
                        leading: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                          ),
                          child: const Icon(Icons.palette),
                        ),
                        contentPadding: const EdgeInsets.all(5),
                        title: Text(
                          artwork.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextThemes.headline1.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
