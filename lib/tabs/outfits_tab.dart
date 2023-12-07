import 'package:flutter/material.dart';
import 'package:rackity/lists/outfits_list.dart';
import 'dart:math';
import '../lists/clothes_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../colors.dart';
import '../widgets/outfits_list_widget.dart';
import '../widgets/filter_widget_outfits.dart';

class OutfitsTab extends StatefulWidget {
  const OutfitsTab({Key? key}) : super(key: key);

  @override
  State<OutfitsTab> createState() => _OutfitsTabState();
}

class _OutfitsTabState extends State<OutfitsTab> {
  @override
  void initState() {
    createOutfit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var side = 128.0;
    var radius = 14.0;

    Widget cuadrados = Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: side,
            height: side,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ]),
          ),
          SizedBox(height: 14),
          Container(
            width: side,
            height: side * 1.2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ]),
          ),
          SizedBox(height: 14),
          Container(
            width: side,
            height: side,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ]),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE7A757),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE7A757),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.swap_horiz,
                      color: Colors.white,
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.primary),
              padding: EdgeInsets.only(
                  left: 16.0, top: 32.0, right: 24.0, bottom: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mis outfits',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.account_circle),
                    iconSize: 32.0,
                    color: textColor,
                    onPressed: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              //Green Background
              child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                            ),
                            padding: EdgeInsets.only(
                              left: 26.0,
                              top: 20.0,
                              right: 24.0,
                              bottom: 10,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Material(
                              color: Color(0xFFF2F2F2),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return FilterWidgetOutfits(); // Display your custom popup widget
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Filtrar',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontWeight: FontWeight.w300,
                                            color: Color(0xFF217269),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.0,
                                          child: Icon(
                                            Icons.keyboard_arrow_right,
                                            color: Color(0xFF217269),
                                            size: 35,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Apply button logic here
                                          },
                                          child: Text('Aplicar'),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adding some spacing between the buttons
                                        ElevatedButton(
                                          onPressed: () {
                                            // Remove filter button logic here
                                          },
                                          child: Text('Quitar filtro'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          OutfitsListWidget(),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }

  void createOutfit() async {
    outfits = await createOutfitsList();
    setState(() {
      outfits;
    });
  }
}
