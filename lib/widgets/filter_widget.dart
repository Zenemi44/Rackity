import 'package:flutter/material.dart';
import 'package:rackity/lists/clothes_list.dart';
import '../colors.dart';
import '../screens/filtered_clothes_list.dart';
import '../tabs/closet_tab.dart' as clo;

class FilterWidget extends StatefulWidget {
  @override
  FilterWidgetState createState() => FilterWidgetState();
}

class FilterWidgetState extends State<FilterWidget> {
  List<String> garmentTags = [
    "Dresses",
    "Outerwear",
    "Activewear",
    "Casual",
    "Formal",
    "Accessories",
    "Swimwear",
    'Top',
    'Bottom',
    'Footwear',
  ];
  static bool filter = false;
  static List<String> selectedTags = [];
  @override
  void initState() {
    selectedTags = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Wrap(
                      spacing: 2,
                      runSpacing: 0,
                      children: garmentTags
                          .map(
                            (tag) => ChoiceChip(
                              label: Text(tag),
                              selected: selectedTags.contains(tag),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedTags.add(tag);
                                  } else {
                                    selectedTags.remove(tag);
                                  }
                                });
                              },
                              selectedColor: Color.fromARGB(172, 228, 171, 101),
                              backgroundColor: Colors.grey[300],
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(
                        height: 16.0), // Add spacing between chips and buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Close the widget
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Ok'),
                        ),
                      ],
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
