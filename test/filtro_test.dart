import 'package:flutter_test/flutter_test.dart';

void main() {
  test('filtrarPrendas filters correctly', () {
    List<Map<String, dynamic>> prendas = [
      {
        'Id': 1,
        'Idusuario': 1,
        'tokenImagen': 'abc123',
        'Color': 'azul',
        'Tipo': 'camisa',
        'Formalidad': 'informal'
      },
      {
        'Id': 2,
        'Idusuario': 1,
        'tokenImagen': 'def456',
        'Color': 'negro',
        'Tipo': 'pantalón',
        'Formalidad': 'formal'
      },
      {
        'Id': 3,
        'Idusuario': 2,
        'tokenImagen': 'ghi789',
        'Color': 'verde',
        'Tipo': 'camisa',
        'Formalidad': 'informal'
      },
      {
        'Id': 4,
        'Idusuario': 2,
        'tokenImagen': 'jkl012',
        'Color': 'azul',
        'Tipo': 'pantalón',
        'Formalidad': 'informal'
      },
    ];

    List<Map<String, dynamic>> filteredPrendas =
        filtrarPrendas(prendas, 'azul', null, 'informal');

    expect(filteredPrendas.length, 2);
    expect(filteredPrendas[0]['Id'], 1);
    expect(filteredPrendas[1]['Id'], 4);

    List<Map<String, dynamic>> filteredPrendas2 =
        filtrarPrendas(prendas, 'azul', null, 'formal');
    expect(filteredPrendas2.length, 0);
  });
}

List<Map<String, dynamic>> filtrarPrendas(List<Map<String, dynamic>> prendas,
    String? color, String? tipo, String? formalidad) {
  return prendas.where((prenda) {
    bool cumpleFiltro = true;
    if (color != null && prenda['Color'] != color) {
      cumpleFiltro = false;
    }
    if (tipo != null && prenda['Tipo'] != tipo) {
      cumpleFiltro = false;
    }
    if (formalidad != null && prenda['Formalidad'] != formalidad) {
      cumpleFiltro = false;
    }
    return cumpleFiltro;
  }).toList();
}
