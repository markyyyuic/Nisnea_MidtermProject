import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<String>((ref) => "User");
final themeProvider = StateProvider<bool>((ref) => false); 

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(userProvider);
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFFFFD1DC), 
      ),
      body: Container(
        color: isDarkMode ? const Color.fromARGB(255, 0, 0, 0) : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_picture.png'), 
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Hello, $userName',
                    style: TextStyle(
                      fontSize: 24,
                      color: isDarkMode ? Colors.white : Color(0xFFFFC6C85),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to the Library Management System!',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? Colors.white : Color(0xFFFFC6C85), 
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildCard(context, 'View Books', Icons.book, '/viewBooks', isDarkMode),
                  SizedBox(height: 10),
                  _buildCard(context, 'Add Book', Icons.add, '/addBook', isDarkMode),
                ],
              ),
            ),
          ],
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
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: isDarkMode ? Colors.white : Color(0xFFFFC6C85)), // Darker pink color
        ),
        leading: Icon(icon, color: isDarkMode ? Colors.white : Color(0xFFFFC6C85)), // Darker pink color
        onTap: () => Navigator.pushNamed(context, route),
      ),
    );
  }
}
