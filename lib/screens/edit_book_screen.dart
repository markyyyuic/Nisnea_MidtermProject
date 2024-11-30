import 'package:flutter/material.dart';
import 'package:nisnea_midterm/models/books.dart';
import 'package:nisnea_midterm/providers/book_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; // Import for custom fonts
import 'view_books_screen.dart'; // Make sure to import ViewBooksScreen

class EditBookScreen extends ConsumerWidget {
  final Book book;

  EditBookScreen({required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController titleController = TextEditingController(text: book.title);
    final TextEditingController authorController = TextEditingController(text: book.author);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Book',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent,
        elevation: 4, // Add a shadow to the app bar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink.shade50, Colors.white], // Gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title TextField with custom styling
                Text(
                  'Title',
                  style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter the book title',
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  style: GoogleFonts.lato(fontSize: 16),
                ),
                SizedBox(height: 20),

                // Author TextField with custom styling
                Text(
                  'Author',
                  style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 8),
                TextField(
                  controller: authorController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Enter the author name',
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  style: GoogleFonts.lato(fontSize: 16),
                ),
                SizedBox(height: 30),

                // Save button with custom styling
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate the inputs
                      if (titleController.text.isEmpty || authorController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please fill in both fields'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Update the book information
                      final updatedBook = book.copyWith(
                        title: titleController.text,
                        author: authorController.text,
                      );

                      // Update the book in the provider
                      ref.read(bookListProvider.notifier).updateBook(updatedBook);

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Book details updated successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Navigate back to ViewBooksScreen after saving
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ViewBooksScreen()),
                      );
                    },
                    child: Text(
                      'Save Changes',
                      style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent, // Button color
                      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      shadowColor: Colors.pink.shade200,
                      elevation: 5, // Add shadow for a 3D effect
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
