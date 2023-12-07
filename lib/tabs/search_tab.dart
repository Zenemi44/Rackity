import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  final List<String> colors = [
    'Brown',
    'Grey',
    'Black',
    'White',
    'Red',
    'Orange',
    'Yellow',
    'Green',
    'Blue',
    'Purple',
    'Pink',
  ];

  final double cardWidth = 150.0;
  final double cardHeight = 100.0;
  final double cardRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search Colors',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: colors.length,
        itemBuilder: (BuildContext context, int index) {
          Color color = _getColorFromString(colors[index]) ?? Colors.grey;
          Color textColor =
              color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
          return Card(
            color: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cardRadius),
            ),
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    colors[index],
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color? _getColorFromString(String colorString) {
    var saturation = 300;
    switch (colorString.toLowerCase()) {
      case 'red':
        return Colors.pink[saturation];
      case 'orange':
        return Colors.orange[saturation];
      case 'yellow':
        return Colors.yellow[saturation];
      case 'green':
        return Colors.green[saturation];
      case 'blue':
        return Colors.blue[saturation];
      case 'purple':
        return Colors.purple[saturation];
      case 'pink':
        return Colors.pink[saturation];
      case 'brown':
        return Colors.brown[saturation];
      case 'grey':
        return Colors.grey[saturation];
      case 'black':
        return Colors.black;
      case 'white':
        return Colors.white;
      default:
        return null;
    }
  }
}
