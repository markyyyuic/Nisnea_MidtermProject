import 'package:flutter/material.dart';

class ViewBooksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Books'),
        backgroundColor: Color(0xFFFFD1DC), 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5,  
          itemBuilder: (context, index) {
            return _buildBookCard(
              title: 'Book Title $index',
              author: 'Author $index',
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookCard({required String title, required String author}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(Icons.book, color: Color(0xFFFFC6C85)), // Darker pink color
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFC6C85)), // Darker pink color
        ),
        subtitle: Text('by $author', style: TextStyle(color: Colors.grey[600])), // Subtitle color remains gray
        trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
      ),
    );
  }
}
