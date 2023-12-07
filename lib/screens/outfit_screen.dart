import 'package:flutter/material.dart';
import '../lists/outfits_list.dart';

class OutfitScreen extends StatelessWidget {
  final Outfit outfit;

  OutfitScreen({required this.outfit});

  Widget build(BuildContext context) {
    var width = 140.0;
    TextStyle info = TextStyle(
      fontSize: 22,
      color: Color(0xFF275844),
      fontWeight: FontWeight.w500,
    );
    return Material(
      color: Color(0xFFF5F5F5),
      child: Container(
        color: Color(0xFFF5F5F5), // set the background color of the container
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 55, 0, 0),
                color: Colors.transparent,
                alignment: Alignment.bottomLeft,
                child: IconButton(
                  iconSize: 80,
                  icon: const Icon(Icons.keyboard_arrow_left),
                  color: Color(0xFF7ABDAE),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 19,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: outfit.top.image,
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: outfit.bottom.image,
                          ),
                        ),
                      ),
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: outfit.shoes.image,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.transparent,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 00, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          ElevatedButton(
                            onPressed: () {
                              // Add your calendar button functionality here
                              print('Calendar button pressed');
                            },
                            child: Text('Calendar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
