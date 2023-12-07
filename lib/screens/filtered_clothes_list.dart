import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../lists/clothes_list.dart';
import '../screens/garment_screen.dart';

class FilteredClothesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Color(0xFFFAFAFA),
        child: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
          child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: clothes.length,
            itemBuilder: (BuildContext context, int index) {
              Garment garment = clothes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GarmentScreen(garment: garment),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromRGBO(39, 88, 76, 0.85).withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      image: clothes[index].image,
                    ),
                  ),
                ),
              );
            },
            staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
            mainAxisSpacing: 4,
            crossAxisSpacing: 15,
          ),
        ),
      ),
    );
  }
}
