import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBookScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    String _bookTitle = '';
    String _author = '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Book'),
        backgroundColor: Color(0xFFFFD1DC), 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Book Title',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onSaved: (value) => _bookTitle = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a book title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Author',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onSaved: (value) => _author = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an author name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Book Added: $_bookTitle by $_author')),
                    );
                     
                  }
                },
                child: Text('Add Book'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC6C85),  
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
