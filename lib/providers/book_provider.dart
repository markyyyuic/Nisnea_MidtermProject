import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nisnea_midterm/models/books.dart'; // Import the Book model

class BookListNotifier extends StateNotifier<List<Book>> {
  BookListNotifier() : super([]);

  // Toggle the status of a book
  void toggleBookStatus(Book book) {
    final updatedBooks = [...state];
    final index = updatedBooks.indexWhere((b) => b.id == book.id);

    if (index != -1) {
      updatedBooks[index] = book.copyWith(
        status: book.status == "borrowed" ? "available" : "borrowed",
      );
      state = updatedBooks;
    }
  }

  // Add a new book
  void addBook(Book book) {
    state = [...state, book];
  }

  // Update an existing book
  void updateBook(Book updatedBook) {
    state = state.map((book) {
      return book.id == updatedBook.id ? updatedBook : book;
    }).toList();
  }

  // Delete a book
  void deleteBook(Book book) {
    state = state.where((b) => b.id != book.id).toList();
  }
}

// Define the provider for the BookListNotifier
final bookListProvider = StateNotifierProvider<BookListNotifier, List<Book>>((ref) {
  return BookListNotifier();
});
