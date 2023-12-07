import 'package:flutter/material.dart';
import 'clothes_list.dart';
import '../auth_service.dart' as auth;
import '../widgets/filter_widget.dart' as fil;

class Outfit {
  final Garment top;
  final Garment bottom;
  final Garment shoes;
  final DateTime date;

  Outfit({required this.top, required this.bottom, required this.shoes, required this.date});
}

//Esta es la lista que se muestra en la app
List<Outfit> outfits = [];

addManual(Outfit manualOutfit) async {
  await auth.AuthService.addOutFitUser(manualOutfit);
}

Future<Outfit> generateAutoOutfit() async {
  Outfit autoOutFit = Outfit(
      top: await getOne("Top"),
      bottom: await getOne("Bottom"),
      shoes: await getOne("Footwear"),
      date: DateTime.now());
  await auth.AuthService.addOutFitUser(autoOutFit);
  return autoOutFit;
}

Future<List<Outfit>> createOutfitsList() async {
  //crear clother sin filtro
  List<Outfit> outfits = [];
  List<String> idOutfits = await auth.AuthService.findOutfitsByUsuario();
  if (fil.FilterWidgetState.filter) {
    idOutfits = await auth.AuthService.filterOutfits(
        idOutfits, fil.FilterWidgetState.selectedTags);
  }
  List<Outfit> outfitss = await auth.AuthService.getOutfitsByID(idOutfits);

//Aquí se llena la lista de outfits. Los outfits se forman a partir de la lista de prendas en clothes_lists.dart
//Esto sólo lo hice con el fin de llenar la UI y hacer pruebas, pero todo esto debe hacerse desde la base de datos
  // for (int i = 1; i <= 5; i++) {
  //   outfits.add(
  //     Outfit(
  //       top: clothes[3],
  //       bottom: clothes[2],
  //       shoes: clothes[1],
  //     ),
  //   );
  // }

  return outfitss;
}
