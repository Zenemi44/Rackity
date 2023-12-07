import 'package:flutter/material.dart';
import '../colors.dart';
import '../data/database.dart';
import '../widgets/custom_textfield_widget.dart';
import '../auth_service.dart' as auth;

double boxWidth = 290.0;
double borderRadius = 50.0;
double boxHeight = 48.0; // Define the box height here

class SignupScreen extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  SignupScreen({Key? key}) : super(key: key);
  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardHeight = screenHeight * 0.6;

    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/rackity_logo.png',
                height: 100, // set the desired height for your logo
              ),
            ),
          ),
          Container(
            height: cardHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFF9ECDC2)],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: const Offset(0, -2),
                ),
              ],
              border: Border.all(
                color: lightGreen,
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Create account',
                      style: TextStyle(
                        color: Color(0xFF61857C),
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 27.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  CustomTextField(
                    controller: usernameController,
                    hintText: 'username',
                  ),
                  SizedBox(height: 12.0),
                  CustomTextField(
                      controller: emailController, hintText: 'email'),
                  SizedBox(height: 12.0),
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'password',
                    obscureText: true,
                  ),
                  SizedBox(height: 12.0),
                  CustomTextField(
                    controller: confirmPasswordController,
                    hintText: 'confirm password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    width: boxWidth * 0.7,
                    height: boxHeight,
                    child: Material(
                      elevation: 5, // Set the elevation for the shadow
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: ElevatedButton(
                        onPressed: () {
                          signUp(usernameController.text,
                              passwordController.text, emailController.text);

                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                        ),
                        child: const Text('Sign up'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: const Text('Log in',
                            style: TextStyle(color: textColor)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void signUp(String username, String password, String email) async {
    await auth.AuthService.signUp(email, password, username);
    //   bool isExistingUser =
    //       await DatabaseHelper.instance.usuarioExist(username, password);
    //   if (isExistingUser) {
    //     //mensaje de ya existe
    //   } else {
    //     await DatabaseHelper.instance.createUsuario(username, password, email);
    //   }
  }
}
