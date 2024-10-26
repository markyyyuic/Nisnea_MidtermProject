import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFD1DC), 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'lib/assets/lmslogo.png', 
                height: 200, 
                width: 500, 
                fit: BoxFit.cover,
              ),
              SizedBox(height: 20),
              Text(
                'Please Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFC6C85), 
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFFF0F5), 
                  labelText: 'Enter Email',
                  labelStyle: TextStyle(color: Color(0xFFFFC6C85)), 
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC6C85)), 
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC6C85)), 
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC6C85)),
                  ),
                  prefixIcon: Icon(
                    Icons.email, 
                    color: Color(0xFFFFC6C85), 
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFFFF0F5), 
                  labelText: 'Enter Password',
                  labelStyle: TextStyle(color: Color(0xFFFFC6C85)), 
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC6C85)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC6C85)), 
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFFC6C85)), 
                  ),
                  prefixIcon: Icon(
                    Icons.lock, 
                    color: Color(0xFFFFC6C85), 
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home'); 
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Color(0xFFFFC6C85),  
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 245, 244, 244),  
                  ),
                ),
              ),
              SizedBox(height: 20),  
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/signup');  
                },
                child: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFFFC6C85), 
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
