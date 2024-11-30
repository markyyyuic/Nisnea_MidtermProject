import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'package:nisnea_midterm/main.dart';
import 'package:nisnea_midterm/models/user_models.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false; // State for showing the loading animation

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    String email = _usernameController.text;
    String password = _passwordController.text;

    // Simulate a login process delay
    await Future.delayed(Duration(seconds: 2));

    if (usersDatabase.containsKey(email)) {
      User user = usersDatabase[email]!;
      if (user.password == password) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successfully!'),
            backgroundColor: Colors.green,
          ),
        );

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid username'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD1DC), Color(0xFFFFF8F9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: _isLoading
                ? _buildLoadingIndicator() // Show loading animation
                : _buildLoginForm(), // Show login form
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: 'appLogo',
          child: Image.asset(
            'lib/assets/lmslogo.png',
            height: 150,
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Welcome Back!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Please login to continue',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 32),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                icon: Icons.person,
              ),
              SizedBox(height: 16),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  elevation: 5,
                  shadowColor: Colors.pinkAccent.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Divider(
          thickness: 1,
          color: Colors.grey[300],
          indent: 40,
          endIndent: 40,
        ),
        SizedBox(height: 16),
        Text(
          'Don\'t have an account?',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: Text('Sign up.'),
          style: TextButton.styleFrom(
            foregroundColor: Colors.pinkAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
          strokeWidth: 6,
        ),
        SizedBox(height: 16),
        Text(
          'Logging you in...',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.pinkAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.pinkAccent),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pinkAccent),
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
    );
  }
}
