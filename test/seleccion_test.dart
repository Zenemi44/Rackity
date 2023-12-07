import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('obtenerPrendasAleatorias', () {
    test('debería devolver una lista con tres prendas', () {
      final prendasFiltradas = obtenerPrendasAleatorias(prendas);
      expect(prendasFiltradas.length, 3);
    });

   test('debería devolver una prenda de tipo superior, una de tipo inferior y una de tipo calzado', () {
      final prendasFiltradas = obtenerPrendasAleatorias(prendas);
      final tipos = prendasFiltradas.map((prenda) => prenda['Tipo']).toList();
      expect(tipos.contains('superior'), true);
      expect(tipos.contains('inferior'), true);
      expect(tipos.contains('calzado'), true);
    });


    test('debería devolver una sola prenda de tipo superior', () {
     final prendasFiltradas = obtenerPrendasAleatorias(prendas);
     final superiores = prendasFiltradas.where((prenda) => prenda['Tipo'] == 'superior').toList();
     expect(superiores.length, 1);
    });

    test('debería devolver una sola prenda de tipo inferior', () {
      final prendasFiltradas = obtenerPrendasAleatorias(prendas);
      final inferiores = prendasFiltradas.where((prenda) => prenda['Tipo'] == 'inferior').toList();
      expect(inferiores.length, 1);
    });

    test('debería devolver una sola prenda de tipo calzado', () {
      final prendasFiltradas = obtenerPrendasAleatorias(prendas);
      final calzados = prendasFiltradas.where((prenda) => prenda['Tipo'] == 'calzado').toList();
      expect(calzados.length, 1);
    });
    test('debería devolver verdadero si hay al menos una prenda de cada tipo', () {
      final prendasFiltradas = obtenerPrendasAleatorias(prendas);
      final resultado = hayPrendaDeCadaTipo(prendasFiltradas);
      expect(resultado, true);
    });
    

  });
}

List<Map<String, dynamic>> prendas = [
  {
    "Id": 1,
    "Idusuario": 1,
    "tokenImagen": "abc123",
    "Color": "azul",
    "Tipo": "superior",
    "Formalidad": "informal",
  },
  {
    "Id": 2,
    "Idusuario": 1,
    "tokenImagen": "def456",
    "Color": "rojo",
    "Tipo": "inferior",
    "Formalidad": "formal",
  },
  {
    "Id": 3,
    "Idusuario": 1,
    "tokenImagen": "ghi789",
    "Color": "verde",
    "Tipo": "calzado",
    "Formalidad": "informal",
  },
  {
    "Id": 4,
    "Idusuario": 1,
    "tokenImagen": "jkl012",
    "Color": "negro",
    "Tipo": "superior",
    "Formalidad": "formal",
  },
];

List<Map<String, dynamic>> obtenerPrendasAleatorias(List<Map<String, dynamic>> prendas) {
  List<Map<String, dynamic>> prendasFiltradas = [];

  // Obtener aleatoriamente una prenda de tipo "superior"
  var prendasSuperiores =
      prendas.where((prenda) => prenda["Tipo"] == "superior" ).toList();
  var prendaSuperior = prendasSuperiores[Random().nextInt(prendasSuperiores.length)];
  prendasFiltradas.add(prendaSuperior);

  // Obtener aleatoriamente una prenda de tipo "inferior"
  var prendasInferiores = prendas.where((prenda) => prenda["Tipo"] == "inferior").toList();
  var prendaInferior = prendasInferiores[Random().nextInt(prendasInferiores.length)];
  prendasFiltradas.add(prendaInferior);

  // Obtener aleatoriamente una prenda de tipo "calzado"
  var prendasCalzado = prendas.where((prenda) => prenda["Tipo"] == "calzado").toList();
  var prendaCalzado = prendasCalzado[Random().nextInt(prendasCalzado.length)];
  prendasFiltradas.add(prendaCalzado);

  return prendasFiltradas;
}

bool hayPrendaDeCadaTipo(List<Map<String, dynamic>> prendas) {
  // Verificar si hay al menos una prenda de cada tipo
  bool haySuperior = false;
  bool hayInferior = false;
  bool hayCalzado = false;

  for (var prenda in prendas) {
    switch (prenda["Tipo"]) {
      case "superior":
        haySuperior = true;
        break;
      case "inferior":
        hayInferior = true;
        break;
      case "calzado":
        hayCalzado = true;
        break;
      default:
        break;
    }
  }

  return haySuperior && hayInferior && hayCalzado;
}




