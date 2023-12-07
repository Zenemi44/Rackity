import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/form_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/database.dart';
import '../colors.dart';
import '../auth_service.dart' as auth;

class CameraTab extends StatefulWidget {
  @override
  State<CameraTab> createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  late File _image;
  bool init = false;

  Future<int?> obtenerIdUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('idUsuario');
  }

  void saveImageToStorage(File imageFile, BuildContext context) async {
    final directory = await getExternalStorageDirectory();
    final imageName =
        'image_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}.jpg';
    final imagePath = '${directory!.path}/my_images/$imageName';

    if (!await Directory('${directory.path}/my_images').exists()) {
      await Directory('${directory.path}/my_images').create(recursive: true);
    }

    await imageFile.copy(imagePath);
    int? idUsuario = await obtenerIdUsuario();
    print("---------------------id de usuario:" + idUsuario.toString());
    await DatabaseHelper.instance.createPrenda(idUsuario!, imagePath, "tipo");

    print("----------------path:" + imagePath.toString());
    //navegacion a closet
  }

  Future<void> _takePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
        init = true;
        // trabajar con la imagen
      }
    });
  }

  @override
  void initState() {
    init = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Widget luego de tomar la foto
    Widget after = Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
                flex: 20,
                child: Container(
                  child: FormScreen(),
                )),
            Expanded(
                flex: 24,
                child: Container(
                  child: init
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: Image.file(_image).image,
                          ),
                        )
                      : Container(),
                )),
            Expanded(
                flex: 8,
                child: Container(
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _takePicture();
                              });
                            },
                            child: Text('Tomar Foto'),
                          ),
                        ),
                        SizedBox(width: 16), // Espacio entre botones
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              if (init) {
                                saveImageToStorage(_image, context);
                                upPhoto();
                                setState(() {
                                  init = false;
                                });
                              }
                            },
                            child: Text('Guardar Foto'),
                          ),
                        ),
                      ],
                    ),
                  )),
                )),
          ],
        ),
      ),
    );

    //Widget antes de tomar la foto
    Widget before = Expanded(
      child: Container(
        child: Column(
          children: [
            Expanded(
                flex: 20,
                child: Container(
                  child: FormScreen(),
                )),
            Expanded(
                flex: 24,
                child: Container(
                  child: init
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: Image.file(_image).image,
                          ),
                        )
                      : Container(),
                )),
            Expanded(
                flex: 8,
                child: Container(
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _takePicture();
                              });
                            },
                            child: Text('Tomar Foto'),
                          ),
                        ),
                        SizedBox(width: 16), // Espacio entre botones
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            onPressed: null,
                            child: Text('Guardar Foto'),
                          ),
                        ),
                      ],
                    ),
                  )),
                )),
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
              padding: EdgeInsets.only(
                  left: 16.0, top: 32.0, right: 24.0, bottom: 16),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Agregar prenda',
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
                                left: 26.0, top: 0, right: 24.0, bottom: 0),
                            alignment: Alignment.centerLeft,
                          ),
                          init ? after : before,
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }

  void upPhoto() async {
    var idUsuario = auth.AuthService.getidUser();
    var tipo = _FormScreenState._selectedGarmentType;
    var lTipos = _FormScreenState._selectedTags;
    var fecha = DateTime(2000, 12, 31, 0, 0);
    const usos = 0;
    String photoUrl = await uploadPhotoToStorage(_image);
    if (photoUrl != null) {
      await auth.AuthService.createPrendaDocument(
          idUsuario, photoUrl, tipo, lTipos, fecha, usos);
    } else {
      // Ocurrió un error al subir la foto al almacenamiento
    }
  }

  Future<void> addPhotoToCollection(String photoUrl) async {
    try {
      final CollectionReference photosCollection =
          FirebaseFirestore.instance.collection('photos');
      await photosCollection.add({
        'url': photoUrl,
        // Otros campos de datos relacionados con la foto
      });
    } catch (e) {
      print('Error adding photo to collection: $e');
    }
  }

  Future<String> uploadPhotoToStorage(File file) async {
    try {
      final name =
          'image_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(1000)}.jpg';
      final Reference storageReference =
          FirebaseStorage.instance.ref().child("photos").child(name);
      final TaskSnapshot snapshot = await storageReference.putFile(file);

      // Obtiene la URL de descarga de la foto
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return 'photos/$name';
    } catch (e) {
      print('Error uploading photo: $e');
      return "null";
    }
  }
}

//Formulario
class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  static String _selectedGarmentType = 'Top';

  List<String> _garmentTypes = [
    'Top',
    'Bottom',
    'Footwear',
  ];

  List<String> _garmentTags = [
    "Dresses",
    "Outerwear",
    "Activewear",
    "Casual",
    "Formal",
    "Accessories",
    "Swimwear"
  ];

  static List<String> _selectedTags = [];
  @override
  void initState() {
    _selectedTags = [];
    _selectedGarmentType = 'Top';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.847).withOpacity(0.08),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _garmentTypes
                          .map(
                            (type) => Row(
                              children: [
                                Radio(
                                  value: type,
                                  groupValue: _selectedGarmentType,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGarmentType = value!;
                                    });
                                  },
                                ),
                                Text(type),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                    Wrap(
                      spacing: 2,
                      runSpacing: 0,
                      children: _garmentTags
                          .map(
                            (tag) => ChoiceChip(
                              label: Text(tag),
                              selected: _selectedTags.contains(tag),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedTags.add(tag);
                                  } else {
                                    _selectedTags.remove(tag);
                                  }
                                });
                              },
                              selectedColor: Color.fromARGB(172, 228, 171,
                                  101), // Set a brighter color here
                              backgroundColor: Colors
                                  .grey[300], // Adjust the background color
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
