import 'package:flutter/material.dart';
import '../lists/clothes_list.dart';

class GarmentScreen extends StatelessWidget {
  final Garment garment;

  GarmentScreen({required this.garment});

  Widget build(BuildContext context) {
    TextStyle info = TextStyle(
      fontSize: 22,
      color: Color(0xFF275844),
      fontWeight: FontWeight.w500,
    );
    return Material(
      child: Container(
        color: Color(0xFFF2F2F2), // set the background color of the container
        child: Column(
          children: [
            Expanded(
              flex: 2,
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
            Expanded(
              flex: 7,
              child: Container(
                padding: EdgeInsets.all(70.0), // add padding here
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(15), // Set rounded corner radius
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withOpacity(0.04), // Set shadow color
                        spreadRadius: 2, // Set shadow spread radius
                        blurRadius: 7, // Set shadow blur radius
                        offset: Offset(0, 3), // Set shadow offset
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      image: garment.image,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFB6D7D0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Container(
                      height: 5,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFF99BEB6),
                      ),
                    ),
                    SizedBox(height: 26), // Add some space at the top
                    Text(
                      'Registro',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF275844),
                      ),
                    ),
                    SizedBox(height: 26), // Add some space between the rows
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          40, 0, 40, 0), // adjust the padding values as needed
                      child: Row(
                        children: [
                          Text(
                            'Última vez usado',
                            style: info,
                          ),
                          Expanded(
                            child: Text(
                              '.' * 100,
                              maxLines: 1,
                              style: info.copyWith(fontWeight: FontWeight.w300),
                            ),
                          ),
                          Text(
                            '25/07',
                            style: info.copyWith(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18), // Add some space between the rows
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        children: [
                          Text(
                            'Veces usado',
                            style: info,
                          ),
                          Expanded(
                              child: Text('.' * 100,
                                  maxLines: 1,
                                  style: info.copyWith(
                                      fontWeight: FontWeight.w300))),
                          Text('15',
                              style:
                                  info.copyWith(fontWeight: FontWeight.w300)),
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
