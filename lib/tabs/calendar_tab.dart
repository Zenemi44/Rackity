import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rackity/lists/outfits_list.dart';
import 'package:rackity/screens/calendar_widget.dart';
import 'package:rackity/tabs/Comparing%20model.dart';
import 'dart:math';
import '../lists/clothes_list.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../colors.dart';
import '../widgets/outfits_list_widget.dart';

class CalendarTab extends StatelessWidget {
  CalendarTab({Key? key}) : super(key: key);
  
final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('purchased').snapshots();

  @override
  Widget build(BuildContext context) {
    var side = 128.0;
    var radius = 14.0;

    Widget tarjetas = Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    size: 32.0,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    // Handle left arrow button press
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Saturday 13/05',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_right,
                    size: 32.0,
                    color: Colors.black54,
                  ),
                  onPressed: () {
                    // Handle right arrow button press
                  },
                ),
              ],
            ),
            Container(
        margin: EdgeInsets.only(),
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
      
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFFBCDED6),
            ),
          );
        }
      
        return ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: (snapshot.data!.size / 3).ceil(),
          itemBuilder: (BuildContext context, int index) {
            int startIndex = index * 3;
            int endIndex = startIndex + 3;
            if (endIndex > snapshot.data!.size) {
              endIndex = snapshot.data!.size;
            }
      
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(endIndex - startIndex, (subIndex) {
                int itemIndex = startIndex + subIndex;
                return Container(
                  width: 100,
                 // height: 350,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFBCDED6),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: snapshot.data!.docs[itemIndex]["images1"] == null? Image(image: clothes[0].image) : Image.network(
                            snapshot.data!.docs[itemIndex]["images1"],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: snapshot.data!.docs[itemIndex]["images2"] == null? Image(image: clothes[0].image) : Image.network(
                            snapshot.data!.docs[itemIndex]["images2"],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: snapshot.data!.docs[itemIndex]["images3"] == null? Image(image: clothes[0].image) : Image.network(
                            snapshot.data!.docs[itemIndex]["images3"],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            );
          },
        );
          },
        ),
      )
      
      
      
            // Container(
              
            //   width: side,
            //   height: side,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(radius),
            //     color: Color.fromARGB(255, 255, 255, 255),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
            //         spreadRadius: 1,
            //         blurRadius: 3,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 14),
            // Container(
            //   width: side,
            //   height: side * 1.2,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(radius),
            //     color: Color.fromARGB(255, 255, 255, 255),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
            //         spreadRadius: 1,
            //         blurRadius: 3,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(height: 14),
            // Container(
            //   width: side,
            //   height: side,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(radius),
            //     color: Color.fromARGB(255, 255, 255, 255),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
            //         spreadRadius: 1,
            //         blurRadius: 3,
            //         offset: Offset(0, 2),
            //       ),
            //     ],
            //   ),
            // ),
            //SizedBox(height: 20),
          ],
        ),
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
              padding: const EdgeInsets.only(
                  left: 16.0, top: 32.0, right: 24.0, bottom: 16),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Calendario',
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
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
                      child: const CalendarScreen(),)))
          ],
        ),
      ),
    );
  }
}