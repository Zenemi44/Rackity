import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../lists/clothes_list.dart';
import '../lists/outfits_list.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('usuarios');
  static final CollectionReference _prendasCollection =
      FirebaseFirestore.instance.collection('prendas');

  static Future<UserCredential?> signUp(
      String email, String password, String username) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _usersCollection.doc(userCredential.user!.uid).set({
        'email': email,
        "username": username,
      });
      return userCredential;
    } catch (e) {
      print('Error signing up: $e');
      return null;
    }
  }

  static String getidUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print("user.uid");
      return user.uid;
    } else {
      // El usuario no está autenticado
      return '';
    }
  }

  static Future<void> createPrendaDocument(String idUsuario, String tokenImagen,
      String tipo, List<String> lTipos, DateTime fecha, int usos) async {
    try {
      await _prendasCollection.add({
        'idUsuario': idUsuario,
        'tokenImagen': tokenImagen,
        'tipo': tipo,
        'lTipos': lTipos,
        'fecha': fecha,
        'usos': usos,
      });
    } catch (e) {
      print('Error creating prenda document: $e');
    }
  }

  static addOutFitUser(Outfit outFit) async {
    var idUsuario = getidUser();
    FirebaseFirestore.instance.collection('outfits').add({
      'idUsuario': idUsuario,
      'idPrendaTop': outFit.top.id,
      'idPrendaBottom': outFit.bottom.id,
      'idPrendaFootwear': outFit.shoes.id,
      'usos': 0,
    }).then((value) {
      print('Documento agregado con ID: ${value.id}');
    }).catchError((error) {
      print('Error al agregar el documento: $error');
    });
  }

  static Future<List<ImageProvider<Object>>> getImagesForUser() async {
    var idUsuario = getidUser();
    List<ImageProvider<Object>> imageProviders = [];

    try {
      final QuerySnapshot prendasSnapshot = await FirebaseFirestore.instance
          .collection('prendas')
          .where(
            'idUsuario',
            isEqualTo: idUsuario,
          )
          .get();

      for (final DocumentSnapshot prendaSnapshot in prendasSnapshot.docs) {
        for (final DocumentSnapshot prendaSnapshot in prendasSnapshot.docs) {}
        final Map<String, dynamic>? data =
            prendaSnapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('tokenImagen')) {
          final String tokenImagen = data['tokenImagen'] as String;

          // Obtén la referencia al archivo en Firebase Storage
          final Reference imageReference =
              FirebaseStorage.instance.ref().child(tokenImagen);
          final String imageUrl = await imageReference.getDownloadURL();

          // Añade el ImageProvider a la lista
          imageProviders.add(Image.network(imageUrl).image);
        }
      }
    } catch (e) {
      print('Error retrieving images for user: $e');
    }

    return imageProviders;
  }

  static Future<List<String>> findPrendasByUsuario() async {
    var idUsuario = getidUser();
    final CollectionReference prendasCollection =
        FirebaseFirestore.instance.collection('prendas');
    final List<String> prendasIDs = [];

    try {
      final QuerySnapshot snapshot = await prendasCollection
          .where('idUsuario', isEqualTo: idUsuario)
          .get();

      for (final DocumentSnapshot doc in snapshot.docs) {
        final String prendaID = doc.id;
        prendasIDs.add(prendaID);
      }
    } catch (e) {
      print('Error finding prendas by usuario: $e');
    }

    return prendasIDs;
  }

  static Future<List<String>> findOutfitsByUsuario() async {
    var idUsuario = getidUser();
    final CollectionReference outfitsCollection =
        FirebaseFirestore.instance.collection('outfits');
    final List<String> outfitsIDs = [];

    try {
      final QuerySnapshot snapshot = await outfitsCollection
          .where('idUsuario', isEqualTo: idUsuario)
          .get();

      for (final DocumentSnapshot doc in snapshot.docs) {
        final String outfitID = doc.id;
        outfitsIDs.add(outfitID);
      }
    } catch (e) {
      print('Error finding outfits by usuario: $e');
    }

    return outfitsIDs;
  }

  static Future<List<String>> filterOutfitsByTipo(
      List<String> outfitsIDs, List<String> filtro) async {
    final List<String> prendasFiltradas = [];

    return prendasFiltradas;
  }

  static Future<List<String>> filterOutfits(
    List<String> outfitsIDs,
    List<String> filtro,
  ) async {
    final CollectionReference outfitsCollection =
        FirebaseFirestore.instance.collection('outfits');
    final List<String> outfitsFiltrados = [];

    try {
      for (final String outfitID in outfitsIDs) {
        final DocumentSnapshot snapshot =
            await outfitsCollection.doc(outfitID).get();
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;

        if (data != null &&
            data.containsKey('idPrendaTop') &&
            data.containsKey('idPrendaBottom') &&
            data.containsKey('idPrendaFootwear')) {
          final String idPrendaTop = data['idPrendaTop'] as String;
          final String idPrendaBottom = data['idPrendaBottom'] as String;
          final String idPrendaFootwear = data['idPrendaFootwear'] as String;

          // Aplica la condición que has mencionado aquí
          if (true) {
            outfitsFiltrados.add(outfitID);
          }
        }
      }
    } catch (e) {
      print('Error filtering outfits: $e');
    }

    return outfitsFiltrados;
  }

  static Future<List<String>> filterPrendasByTipo(
      List<String> prendasIDs, List<String> filtro) async {
    final CollectionReference prendasCollection =
        FirebaseFirestore.instance.collection('prendas');
    final List<String> prendasFiltradas = [];

    try {
      for (final String prendaID in prendasIDs) {
        final DocumentSnapshot snapshot =
            await prendasCollection.doc(prendaID).get();
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;

        if (data != null &&
            data.containsKey('lTipos') &&
            data.containsKey('tipo')) {
          final List<dynamic> lTipos = data['lTipos'] as List<dynamic>;
          final String tipo = data['tipo'] as String;

          if (lTipos.any((element) => filtro.contains(element)) ||
              filtro.contains(tipo)) {
            prendasFiltradas.add(prendaID);
          }
        }
      }
    } catch (e) {
      print('Error filtering prendas by tipo: $e');
    }

    return prendasFiltradas;
  }

  static Future<List<Garment>> getImagesForPrendas(
      List<String> prendasIDs) async {
    List<Garment> imageProviders = [];

    try {
      for (final String prendaID in prendasIDs) {
        final DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('prendas')
            .doc(prendaID)
            .get();
        final Map<String, dynamic>? data =
            snapshot.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('tokenImagen')) {
          final String tokenImagen = data['tokenImagen'] as String;

          // Obtén la referencia al archivo en Firebase Storage
          final Reference imageReference =
              FirebaseStorage.instance.ref().child(tokenImagen);
          final String imageUrl = await imageReference.getDownloadURL();

          // Añade el ImageProvider a la lista
          imageProviders
              .add(Garment(id: prendaID, image: Image.network(imageUrl).image));
        }
      }
    } catch (e) {
      print('Error retrieving images for prendas: $e');
    }

    return imageProviders;
  }

  static Future<UserCredential?> signIn(
      String email, String password, context) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushNamed(context, '/tabs');
      return userCredential;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  static Future<UserCredential?> signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      Navigator.pushNamed(context, '/tabs');
      return userCredential;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  static Future<List<Outfit>> getOutfitsByID(List<String> outfitsIDs) async {
    final CollectionReference outfitsCollection =
        FirebaseFirestore.instance.collection('outfits');
    final CollectionReference prendasCollection =
        FirebaseFirestore.instance.collection('prendas');
    final List<Outfit> outfits = [];

    try {
      for (final String outfitID in outfitsIDs) {
        final DocumentSnapshot outfitSnapshot =
            await outfitsCollection.doc(outfitID).get();
        final Map<String, dynamic>? outfitData =
            outfitSnapshot.data() as Map<String, dynamic>?;

        if (outfitData != null &&
            outfitData.containsKey('idPrendaTop') &&
            outfitData.containsKey('idPrendaBottom') &&
            outfitData.containsKey('idPrendaFootwear')) {
          final String idPrendaTop = outfitData['idPrendaTop'] as String;
          final String idPrendaBottom = outfitData['idPrendaBottom'] as String;
          final String idPrendaFootwear =
              outfitData['idPrendaFootwear'] as String;

          final DocumentSnapshot topSnapshot =
              await prendasCollection.doc(idPrendaTop).get();
          final DocumentSnapshot bottomSnapshot =
              await prendasCollection.doc(idPrendaBottom).get();
          final DocumentSnapshot footwearSnapshot =
              await prendasCollection.doc(idPrendaFootwear).get();

          final String topTokenImage =
              topSnapshot['tokenImagen'] as String? ?? '';
          final String bottomTokenImage =
              bottomSnapshot['tokenImagen'] as String? ?? '';
          final String footwearTokenImage =
              footwearSnapshot['tokenImagen'] as String? ?? '';

          final Reference topImageReference =
              FirebaseStorage.instance.ref().child(topTokenImage);
          final Reference bottomImageReference =
              FirebaseStorage.instance.ref().child(bottomTokenImage);
          final Reference footwearImageReference =
              FirebaseStorage.instance.ref().child(footwearTokenImage);

          final String topImageUrl = await topImageReference.getDownloadURL();
          final String bottomImageUrl =
              await bottomImageReference.getDownloadURL();
          final String footwearImageUrl =
              await footwearImageReference.getDownloadURL();

          final Garment topGarment =
              Garment(id: idPrendaTop, image: Image.network(topImageUrl).image);
          final Garment bottomGarment = Garment(
              id: idPrendaBottom, image: Image.network(bottomImageUrl).image);
          final Garment footwearGarment = Garment(
              id: idPrendaFootwear,
              image: Image.network(footwearImageUrl).image);

          final Outfit outfit = Outfit(
              top: topGarment, bottom: bottomGarment, shoes: footwearGarment,date: DateTime.now());
          outfits.add(outfit);
        }
      }
    } catch (e) {
      print('Error retrieving outfits by ID: $e');
    }

    return outfits;
  }
}
