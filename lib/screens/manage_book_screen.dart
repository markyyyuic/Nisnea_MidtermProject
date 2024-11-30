import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nisnea_midterm/providers/book_provider.dart';
import 'package:nisnea_midterm/models/books.dart';

class AddBookScreen extends ConsumerStatefulWidget {
  @override
  _AddBookScreenState createState() => _AddBookScreenState();

  final Book book;

  AddBookScreen({required this.book});

}

class _AddBookScreenState extends ConsumerState<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  void _addBook() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now();
      final formattedDate = DateFormat('MMM d, yyyy').format(now);
      final formattedTime = DateFormat('h:mm a').format(now);

      // Create a new Book instance
      final newBook = Book(
        id: DateTime.now().toString(),  // Ensure you generate a unique ID
        title: _titleController.text,
        author: _authorController.text,
        date: formattedDate,
        status: "available", 
        time: '',  // Default status
      );

      // Use the provider to add the book
      ref.read(bookListProvider.notifier).addBook(newBook);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Book "${_titleController.text}" added!')),
      );

      _titleController.clear();
      _authorController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final books = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
        backgroundColor: Color(0xFFFFC6C85), // Your specified color
        elevation: 4.0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFD1DC), Color(0xFFFFC6C85)], // Your specified colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 10.0,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add a New Book',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFC6C85), // Your specified color
                    ),
                  ),
                  SizedBox(height: 16),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildTextField(
                          controller: _titleController,
                          labelText: 'Book Title',
                          icon: Icons.book_outlined,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(
                          controller: _authorController,
                          labelText: 'Author',
                          icon: Icons.person_outline,
                        ),
                        SizedBox(height: 24),
                        _buildElevatedButton(),
                      ],
                    ),
                  ),
                  Divider(thickness: 1, height: 40),
                  Text(
                    'Recently Added Books',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFFC6C85), // Your specified color
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        final book = books[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            title: Text(
                              book.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFC6C85), // Your specified color
                              ),
                            ),
                            subtitle: Text(
                              '${book.date} • ${book.status}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFFFFC6C85), // Your specified color
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Color(0xFFFFC6C85)), // Your specified color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFFFC6C85), width: 2), // Your specified color
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      onPressed: _addBook,
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFFC6C85), // Your specified color
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32), // More padding for a larger button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // More rounded corners for a softer look
        ),
        elevation: 12.0, // Added a subtle shadow for better emphasis
        shadowColor: Color(0xFFB47F49), // A shadow color that complements your button color
      ),
      child: Text(
        'Add Book',
        style: TextStyle(
          fontSize: 20, // Larger font size for better visibility
          fontWeight: FontWeight.bold,
          color: Colors.white, // White text to contrast with the button color
          letterSpacing: 1.2, // Added letter spacing for a more polished look
        ),
      ),
    );
  }
}
