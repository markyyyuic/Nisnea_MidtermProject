class Book {
  final String id;
  final String title;
  final String author;
  final String date;
  final String time;
  final String status;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.time,
    required this.status,
  });

  // Updated CopyWith method to include 'time'
  Book copyWith({
    String? title,
    String? author,
    String? date,
    String? time,  // Add 'time' to the copyWith method
    String? status,
  }) {
    return Book(
      id: this.id,  // Keep id unchanged
      title: title ?? this.title,
      author: author ?? this.author,
      date: date ?? this.date,
      time: time ?? this.time,  // Allow time to be updated
      status: status ?? this.status,
    );
  }
}
