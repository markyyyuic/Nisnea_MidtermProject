import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nisnea_midterm/providers/book_provider.dart';  // Import the book provider
import 'package:nisnea_midterm/screens/edit_book_screen.dart';  // Import AddBookScreen
import 'package:nisnea_midterm/models/books.dart';  // Import the Book model

class ViewBooksScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(bookListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('View Books'),
        backgroundColor: Colors.pinkAccent,
        elevation: 4.0,
      ),
      body: books.isEmpty
          ? Center(
              child: Text(
                'No books added yet.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];

                return Dismissible(
                  key: ValueKey(book.title), // Ensure each Dismissible has a unique key
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.orange,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.edit, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.startToEnd) {
                      // Delete Action
                      ref.read(bookListProvider.notifier).deleteBook(book);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Book "${book.title}" deleted!')),
                      );
                    } else if (direction == DismissDirection.endToStart) {
                      // Edit Action (Swipe Right)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditBookScreen(book: book),  // Passing the book object
                        ),
                      );
                    }
                  },
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // Confirm delete action
                      return await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Confirm Delete'),
                          content: Text('Are you sure you want to delete "${book.title}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    }
                    return true; // Allow edit without confirmation
                  },
                  child: Card(
                    elevation: 8,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            book.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, size: 18, color: Colors.pinkAccent),
                              SizedBox(width: 8),
                              Text(
                                book.author,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(Icons.calendar_today, size: 18, color: Colors.pinkAccent),
                              SizedBox(width: 8),
                              Text(
                                'Added on: ${book.date}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 18, color: Colors.pinkAccent),
                              SizedBox(width: 8),
                              Text(
                                'At: ${book.time}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Chip(
                                label: Text(
                                  book.status == 'borrowed' ? 'Borrowed' : 'Available',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: book.status == 'borrowed'
                                    ? Colors.green
                                    : Colors.blue,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  ref.read(bookListProvider.notifier).toggleBookStatus(book);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    book.status == "borrowed"
                                        ? Colors.green
                                        : Colors.blue,
                                  ),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  ),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  book.status == "borrowed" ? 'Return' : 'Borrow',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 1, color: Colors.grey[300]),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
