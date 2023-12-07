import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../colors.dart';
import '../lists/outfits_list.dart';
import '../screens/clothes_picker_widget.dart';
import '../lists/clothes_list.dart';
import 'Comparing model.dart';
import '../auth_service.dart' as auth;

class GenerateTab extends StatefulWidget {
  @override
  _GenerateTabState createState() => _GenerateTabState();
}

class _GenerateTabState extends State<GenerateTab> {
  int _selectedIndex3 = 0;
  int _selectedIndex2 = 0;
  int _selectedIndex1 = 0;
  Outfit? manualOutfit;

  _onSelected(int index) {
    setState(() => _selectedIndex3 = index);
  }

  List<Garment> top = [];
  List<Garment> bottom = [];
  List<Garment> footwear = [];

  List topList = [];
  List bottomList = [];
  List footwearList = [];
  createTop() async {
    List<String> tokens = await auth.AuthService.findPrendasByUsuario();

    tokens = await auth.AuthService.filterPrendasByTipo(tokens, ["Top"]);
    List<Garment> images = await auth.AuthService.getImagesForPrendas(tokens);
    top = images;
    print("t");
    print(top);
    var a = top.map((e) => CompareModel(
          shirtI: e.image,
          idS: e.id,
        ));
    print(a);
    setState(() {
      topList.addAll(a);
    });
  }

  createBottom() async {
    List<String> tokens = await auth.AuthService.findPrendasByUsuario();

    tokens = await auth.AuthService.filterPrendasByTipo(tokens, ["Bottom"]);
    List<Garment> images = await auth.AuthService.getImagesForPrendas(tokens);
    bottom = images;
    print("b");
    print(bottom);
    var b = bottom.map((e) => CompareModel(
          paintI: e.image,
          idP: e.id,
        ));
    setState(() {
      bottomList.addAll(b);
    });
  }

  createFootwear() async {
    List<String> tokens = await auth.AuthService.findPrendasByUsuario();

    tokens = await auth.AuthService.filterPrendasByTipo(tokens, ["Footwear"]);
    List<Garment> images = await auth.AuthService.getImagesForPrendas(tokens);
    footwear = images;
    print("f");
    print(footwear);
    var c = footwear.map((e) => CompareModel(
          shoesI: e.image,
          idSh: e.id,
        ));
    setState(() {
      footwearList.addAll(c);
    });
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    setState(() {});
    // TODO: implement initState
    createTop();
    createBottom();
    createFootwear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var side = 128.0;
    var radius = 14.0;
    return Scaffold(
        backgroundColor: Color(0xFFBCDED6),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35.0),
                      bottomRight: Radius.circular(35.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(16.0, 68.0, 16.0, 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Code to be executed when the 'Auto' button is pressed
                        generateAutoOutfit();
                      },
                      child: Text(
                        'Auto',
                        style: TextStyle(
                          color: Color(
                              0xFF27584C), // Set the text color to #27584C
                          fontSize: 18, // Set the font size to 20
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(105, 42)),
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFFAAD2C9),
                        ), // Use #AAD2C9 color
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              14), // Make the radius smaller
                        )),
                      ),
                    ),
                    SizedBox(width: 16), // Add some space between the buttons
                    ElevatedButton(
                      onPressed: () {
                        // Code to be executed when the 'Manual' button is pressed
                        manualOutfit = Outfit(
                            top: Garment(
                                id: topList[_selectedIndex1].idS,
                                image: topList[_selectedIndex1].shirtI),
                            bottom: Garment(
                                id: bottomList[_selectedIndex2].idP,
                                image: bottomList[_selectedIndex2].paintI),
                            shoes: Garment(
                                id: footwearList[_selectedIndex3].idSh,
                                image: footwearList[_selectedIndex3].shoesI),
                            date: DateTime.now());
                        addManual(manualOutfit!);
                      },
                      child: Text(
                        'Guardar Manual',
                        style: TextStyle(
                          color: Color(
                              0xFF27584C), // Set the text color to #27584C
                          fontSize: 18, // Set the font size to 20
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(105, 42)),
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xFFAAD2C9),
                        ), // Use #AAD2C9 color
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              14), // Make the radius smaller
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: topList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex1 = index;
                        });
                      },
                      child: Container(
                        width: side,
                        height: side,
                        child: topList[index].shirt == null
                            ? Image(image: topList[index].shirtI)
                            : Image.network(topList[index].shirt.toString()),
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 30, bottom: 10),
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: NetworkImage(
                            //       tophtllist[index].image.toString(),
                            //    ), fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(radius),
                            color: _selectedIndex1 != null &&
                                    _selectedIndex1 == index
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color(0xFFBCDED6),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.847)
                                    .withOpacity(0.08),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: bottomList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex2 = index;
                        });
                      },
                      child: Container(
                        child: bottomList[index].paint == null
                            ? Image(image: bottomList[index].paintI)
                            : Image.network(bottomList[index].paint.toString()),
                        // child: Image.asset(Images[index].toString()),
                        width: side,
                        height: side,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: _selectedIndex2 != null &&
                                    _selectedIndex2 == index
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color(0xFFBCDED6),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.847)
                                    .withOpacity(0.08),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: footwearList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _onSelected(index);
                        });
                      },
                      child: Container(
                        child: footwearList[index].shoes == null
                            ? Image(image: footwearList[index].shoesI)
                            : Image.network(
                                footwearList[index].shoes.toString()),
                        // child: Image.asset(Images[index].toString()),
                        width: side,
                        height: side,
                        margin: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: _selectedIndex3 != null &&
                                    _selectedIndex3 == index
                                ? Color.fromARGB(255, 255, 255, 255)
                                : Color(0xFFBCDED6),
                            // color: _selectedIndex==null?Color.fromARGB(255, 255, 255, 255):Colors.black,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.847)
                                    .withOpacity(0.08),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: Offset(0, 2),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              ),
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
                                     Icons.swap_horiz,
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
                                 Icons.add,
                                 color: Colors.white,
                               ),
                               onPressed: () {},
                             ),
                           ),
                         ),
                ],
              ),
                   
              // Expanded(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => ClothesPickerWidget(),
              //             ),
              //           );
              //         },
              //         child: Container(
              //           width: side,
              //           height: side,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(radius),
              //               color: Color.fromARGB(255, 255, 255, 255),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Color.fromRGBO(0, 0, 0, 0.847)
              //                       .withOpacity(0.08),
              //                   spreadRadius: 1,
              //                   blurRadius: 3,
              //                   offset: Offset(0, 2),
              //                 ),
              //               ]),
              //         ),
              //       ),
              //       SizedBox(height: 14),
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => ClothesPickerWidget(),
              //             ),
              //           );
              //         },
              //         child: Container(
              //           width: side,
              //           height: side * 1.2,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(radius),
              //             color: Color.fromARGB(255, 255, 255, 255),
              //             boxShadow: [
              //               BoxShadow(
              //                 color:
              //                     Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
              //                 spreadRadius: 1,
              //                 blurRadius: 3,
              //                 offset: Offset(0, 2),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       SizedBox(height: 14),
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) => ClothesPickerWidget(),
              //             ),
              //           );
              //         },
              //         child: Container(
              //           width: side,
              //           height: side,
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(radius),
              //               color: Color.fromARGB(255, 255, 255, 255),
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Color.fromRGBO(0, 0, 0, 0.847)
              //                       .withOpacity(0.08),
              //                   spreadRadius: 1,
              //                   blurRadius: 3,
              //                   offset: Offset(0, 2),
              //                 ),
              //               ]),
              //         ),
              //       ),
              //       SizedBox(height: 20),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 10.0),
              //             child: Container(
              //               width: 40,
              //               height: 40,
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Color(0xFFE7A757),
              //               ),
              //               child: IconButton(
              //                 icon: Icon(
              //                   Icons.add,
              //                   color: Colors.white,
              //                 ),
              //                 onPressed: () {},
              //               ),
              //             ),
              //           ),
              //           Padding(
              //             padding: EdgeInsets.symmetric(horizontal: 10.0),
              //             child: Container(
              //               width: 40,
              //               height: 40,
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //                 color: Color(0xFFE7A757),
              //               ),
              //               child: IconButton(
              //                 icon: Icon(
              //                   Icons.swap_horiz,
              //                   color: Colors.white,
              //                 ),
              //                 onPressed: () {},
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              //     ],
              //   ),
              // )

              // Add the rest of your content here...
            ],
          ),
        ));
  }
}
