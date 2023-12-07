import 'package:flutter/material.dart';
import 'package:rackity/tabs/Comparing%20model.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../lists/outfits_list.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  //final List<CompareModel> compiList;


  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDate = DateTime.now();
  var size = 60.0;
    var x = 7.0;
    var y = -12.0;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    final clothesToShow = outfits.where((outfit) => isSameDay(outfit.date, selectedDate)).toList();

    return Column(
        children: [
          // Scrollable list of dates
          Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              selectedDate != null
                  ? '${DateFormat('dd/MM/yyyy').format(selectedDate)}'
                  : 'No date selected',
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
          ],
        ),
      ),

          // Content grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the column count according to your needs
              ),
              itemCount: clothesToShow.length,
              itemBuilder: (context, index) {
                final outfit = clothesToShow[index];

                return GestureDetector(
                  onTap: () {
                    // Handle item selection
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: clothesGroup(outfit),
                  ),
                );
              },
            ),
          ),
        ],
      );
  }

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

  String _getMonthAbbreviation(int month) {
    // Implement your own logic to get the month abbreviation
    // Here's a basic example
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
