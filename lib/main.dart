import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rackity/tabs/outfits_tab.dart';
import 'package:rackity/tabs/profile_tab.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/tabs_screen.dart';
import 'widgets/clothes_list_widget.dart';
import 'screens/form_screen.dart';
import 'tabs/closet_tab.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const Color textColor = Color(0xFF275844); // Add this line

  @override
  Widget build(BuildContext context) {
    final customTheme = ThemeData(
      fontFamily: 'JosefinSans',
      primaryColor: const Color(0xFF63BFAE),
      colorScheme: const ColorScheme.light().copyWith(
        primary: const Color(0xFF63BFAE),
        secondary: const Color(0xFFF2A444),
        // Define textColor with your desired value
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rackity',
      theme: customTheme,
      home: LoginScreen(),
      routes: {
        '/tabs': (context) => TabsScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/form': (context) => FormScreen(),
        '/profile': (context) => ProfileTab(),
        '/closet': (context) => ClosetTab(),
        '/outfits': (context) => OutfitsTab(),
      },
    );
  }
}
