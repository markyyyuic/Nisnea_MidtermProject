import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nisnea_midterm/providers/theme_providers.dart';
import 'profile_screen.dart'; // Import your ProfileScreen here

class SettingsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFFFFD1DC), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Dark Mode', style: TextStyle(color: isDarkMode ? Colors.white : Color(0xFFFFC6C85))), // Darker pink color
              trailing: Switch(
                value: isDarkMode,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).state = value; 
                },
              ),
            ),
            Divider(), 
            ListTile(
              title: Text('Profile Settings', style: TextStyle(color: Color(0xFFFFC6C85))), // Darker pink color
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(), 
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
