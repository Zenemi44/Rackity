import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_service.dart' as auth;
import '../data/database.dart';
import 'package:flutter/widgets.dart';
import '../widgets/filter_widget.dart' as fil;

class Garment {
  final String id;
  final ImageProvider<Object> image;

  Garment({required this.id, required this.image});
}

List<Garment> clothes = [];

Future<Garment> getOne(String tipo) async {
  List<String> idImages = await auth.AuthService.findPrendasByUsuario();
  List<String> filtered =
      await auth.AuthService.filterPrendasByTipo(idImages, [tipo]);
  List<Garment> images = await auth.AuthService.getImagesForPrendas(filtered);
  return getRandomGarment(images);
}

Garment getRandomGarment(List<Garment> garments) {
  if (garments.isEmpty) {
    throw Exception('La lista de prendas está vacía');
  }

  final Random random = Random();
  final int randomIndex = random.nextInt(garments.length);

  return garments[randomIndex];
}

Future<int?> obtenerIdUsuario() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('idUsuario');
}

Future<List<Garment>> createGarmentsList() async {
  print("----------------------------");
  List<String> tokens = await auth.AuthService.findPrendasByUsuario();
  if (fil.FilterWidgetState.filter) {
    tokens = await auth.AuthService.filterPrendasByTipo(
        tokens, fil.FilterWidgetState.selectedTags);
  }
  List<Garment> images = await auth.AuthService.getImagesForPrendas(tokens);

  return images;
}

// List<ImageProvider<Object>> obtenerImageProviders(List<String> rutasImagenes) {
//   List<ImageProvider<Object>> imageProviders = [];
//   for (String rutaImagen in rutasImagenes) {
//     ImageProvider<Object> imageProvider = FileImage(File(rutaImagen));
//     imageProviders.add(imageProvider);
//   }
//   return imageProviders;
// }