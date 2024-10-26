import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/home_screen.dart';
import 'screens/view_books_screen.dart';
import 'screens/add_book_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';
import 'providers/theme_providers.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(themeDataProvider);
    return MaterialApp(
      title: 'Library Management System',
      theme: themeData,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/viewBooks': (context) => ViewBooksScreen(),
        '/addBook': (context) => AddBookScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
