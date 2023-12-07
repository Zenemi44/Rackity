import 'package:flutter/material.dart';
import '../dialogs/logout_dialog.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
          child: Card(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: 350,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor:
                      Color(0xFFB2DFBD), // set the background color to red
                  child: Transform.scale(
                    scale: 3.0,
                    child: Icon(
                      Icons.person,
                      color: Color.fromARGB(
                          255, 89, 112, 95), // set the icon color to blue
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '@johndoe',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'johndoe@example.com',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => LogoutDialog(),
                    ).then((result) {
                      if (result == true) {
                        // Perform logout action
                      }
                    });
                  },
                  child: const Text('Log out'),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
