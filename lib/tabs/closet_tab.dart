import 'package:flutter/material.dart';
import 'package:rackity/widgets/clothes_list_widget.dart';
import '../colors.dart';
import '../lists/clothes_list.dart';
import '../widgets/filter_widget.dart';
import '../screens/login_screen.dart';
import '../widgets/filter_widget.dart' as fil;

class ClosetTab extends StatefulWidget {
  const ClosetTab({Key? key}) : super(key: key);

  @override
  State<ClosetTab> createState() => ClosetTabState();
}

class ClosetTabState extends State<ClosetTab> {
  @override
  void initState() {
    //Comenta la siguiente linea para quitar el error:

    createClothes();
    // fil.FilterWidgetState.filter = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              padding: EdgeInsets.only(
                left: 16.0,
                top: 32.0,
                right: 24.0,
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mis prendas',
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
                                      return FilterWidget(); // Display your custom popup widget
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
                                            if (fil.FilterWidgetState
                                                    .selectedTags ==
                                                []) {
                                            } else {
                                              fil.FilterWidgetState.filter =
                                                  true;
                                              createClothes();
                                            }
                                          },
                                          child: Text('Aplicar'),
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Adding some spacing between the buttons
                                        ElevatedButton(
                                          onPressed: () {
                                            // Remove filter button logic here
                                            fil.FilterWidgetState.filter =
                                                false;
                                            createClothes();
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
                          ClothesListWidget(),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }

  void createClothes() async {
    clothes = await createGarmentsList();
    setState(() {
      clothes;
    });
  }
}
