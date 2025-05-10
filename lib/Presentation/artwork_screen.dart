import 'package:flutter/material.dart';
import 'package:green_tech_test/Model/picture.dart';

import 'Themes/textThemes.dart';

class ArtworkScreen extends StatelessWidget {
  const ArtworkScreen({super.key, required this.artwork});

  final Picture artwork;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artwork.title)),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;
            return SizedBox(
              height: height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  // art details
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: width * 0.08,
                        right: width * 0.08,
                      ),
                      padding: const EdgeInsets.fromLTRB(10, 45, 10, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            artwork.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextThemes.headline1.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Art Type: ${artwork.type}',
                            style: TextThemes.text.copyWith(fontSize: 12),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            text: TextSpan(
                              text: 'Artist: ',
                              style: TextThemes.text.copyWith(fontSize: 12),
                              children: [
                                TextSpan(
                                  text: artwork.artist,
                                  style: TextThemes.text.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                'Date Displayed: ',
                                style: TextThemes.text.copyWith(fontSize: 12),
                              ),
                              Text(
                                artwork.dateDisplayed,
                                style: TextThemes.text.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Made in: ${artwork.country}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextThemes.text.copyWith(fontSize: 12),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  // art icon
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: const Icon(Icons.palette_outlined, size: 40),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
