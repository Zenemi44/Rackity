import 'package:flutter/material.dart';
import 'package:rackity/lists/outfits_list.dart';
import 'dart:math';
import '../lists/clothes_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../screens/outfit_screen.dart';

class OutfitsListWidget extends StatelessWidget {
  const OutfitsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = 60.0;
    var x = 7.0;
    var y = -12.0;

    Widget clothesGroup(Outfit outfit) {
      return Container(
        width: 150,
        height: 150,
        child: Stack(
          children: [
            Positioned(
              top: 40 + y,
              left: 24 + x,
              child: Transform.rotate(
                angle: 18 * pi / 180,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  width: size,
                  constraints: BoxConstraints(
                    maxHeight: size * 1.2,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: outfit.top.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 80 + y,
              left: 55 + x,
              child: Transform.rotate(
                angle: -10 * pi / 180, // Convert 30 degrees to radians
                child: Container(
                  width: size,
                  constraints: BoxConstraints(
                    maxHeight: size * 1.4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: outfit.bottom.image,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 33 + y,
              left: 75 + x,
              child: Transform.rotate(
                angle: -15 * pi / 180, // Convert 30 degrees to radians
                child: Container(
                  width: size,
                  constraints: BoxConstraints(
                    maxHeight: size * 1.2,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: outfit.shoes.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: outfits.length,
            itemBuilder: (BuildContext context, int index) {
              Outfit outfit = outfits[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OutfitScreen(outfit: outfit),
                    ),
                  );
                },
                child: clothesGroup(outfit),
              );
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 0,
          ),
        ),
      ),
    );
  }
}
