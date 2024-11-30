import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/manage_book_screen.dart';
import 'screens/view_books_screen.dart';
import 'models/user_models.dart';
import 'screens/settings_screen.dart';
import 'providers/theme_providers.dart';
import 'models/books.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

Map<String, User> usersDatabase = {};

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Final Project',
      theme: isDarkMode
          ? ThemeData.dark().copyWith(
              primaryColor: Color(0xFFFFD1DC),
              scaffoldBackgroundColor: Colors.black,
            )
          : ThemeData.light().copyWith(
              primaryColor: Color(0xFFFFD1DC),
              scaffoldBackgroundColor: Color(0xFFFFF8F9),
            ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/manageBooks': (context) => AddBookScreen(book: Book(id: '', title: '', author: '', date: '', time: '', status: '')), // Pass an empty book object for adding a new book
        '/viewBooks': (context) => ViewBooksScreen(),
        '/settings': (context) => SettingsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
