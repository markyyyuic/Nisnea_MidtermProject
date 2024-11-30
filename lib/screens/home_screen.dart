
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:nisnea_midterm/providers/user_provider.dart';
import 'package:nisnea_midterm/providers/theme_providers.dart'; 

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
   
    final user = ref.watch(userProvider);
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Library Management System'),
        backgroundColor: Color(0xFFFFD1DC),
        elevation: 4.0,
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/profile_picture.png'),
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Hello, ${user.name.split(' ')[0]}!', 
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Color(0xFFFFC6C85),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to the Library Management System!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Color(0xFFFFC6C85),
                ),
              ),
              SizedBox(height: 30),
              
              _buildCard(context, 'View Books', Icons.book, '/viewBooks', isDarkMode),
              SizedBox(height: 15),
              _buildCard(context, 'Manage Books', Icons.manage_search, '/manageBooks', isDarkMode),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: 0,
        selectedItemColor: isDarkMode ? Colors.amber[800] : Color(0xFFFFC6C85),
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushNamed(context, '/library');
              break;
            case 2:
              Navigator.pushNamed(context, '/settings');
              break;
          }
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String route, bool isDarkMode) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: isDarkMode ? Colors.white : Color(0xFFFFC6C85),
          ),
        ),
        leading: Icon(icon, color: isDarkMode ? Colors.white : Color(0xFFFFC6C85)),
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
