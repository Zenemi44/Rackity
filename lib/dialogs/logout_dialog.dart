import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../auth_service.dart' as auth;

class LogoutDialog extends StatelessWidget {
  LogoutDialog({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _signOut() async {
    await _auth.signOut();

    // Si se utilizó la autenticación de Google, también se debe desconectar de Google Sign-In.

    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await auth.AuthService.signOut();
            // Navigate to the home page
            Navigator.of(context).pop(true);
            Navigator.of(context).pushNamed('/');
          },
          child: const Text('Log out'),
        ),
      ],
    );
  }
}
