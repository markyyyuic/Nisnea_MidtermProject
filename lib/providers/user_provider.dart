// user_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nisnea_midterm/models/user_models.dart';  // Import the User model

// Define the userProvider to manage a User object
final userProvider = StateProvider<User>((ref) => User(name: "User", email: "user@example.com", password: "password"));
