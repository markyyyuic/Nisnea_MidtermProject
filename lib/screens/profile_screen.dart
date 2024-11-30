import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import Riverpod
import 'package:nisnea_midterm/models/user_models.dart';
import 'package:nisnea_midterm/providers/user_provider.dart';
import 'package:nisnea_midterm/providers/theme_providers.dart';
import 'package:nisnea_midterm/screens/login_screen.dart'; // Import LoginScreen

class ProfileSettings extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current logged-in user from the userProvider
    final user = ref.watch(userProvider);

    // Get dark mode preference
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Settings'),
        backgroundColor: Color(0xFFFFD1DC),
        elevation: 6.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture Section with shadow and border
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile_picture.png'),
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 20),
              // User's First Name Greeting
              Text(
                'Hello, ${user.name.split(' ')[0]}!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Color(0xFFFFC6C85),
                ),
              ),
              SizedBox(height: 10),
              // User Email Section
              Text(
                'Email: ${user.email}',
                style: TextStyle(
                  fontSize: 18,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 30),
              // Edit Profile Button
              ElevatedButton(
                onPressed: () {
                  // Add navigation to Edit Profile screen
                },
                child: Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFFC6C85),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  minimumSize: Size(200, 0),
                ),
              ),
              SizedBox(height: 20),
              // Settings Section (Additional actions like password change)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Change Password',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.lock, color: isDarkMode ? Colors.white : Colors.black),
                      onTap: () {
                        // Add functionality to change password
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red, // Highlight Logout text in red
                        ),
                      ),
                      trailing: Icon(Icons.exit_to_app, color: Colors.red),
                      onTap: () {
                        // Navigate to LoginScreen and clear navigation stack
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
