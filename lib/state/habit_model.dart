class Habit {
  final String id; // Unique identifier for the habit
  final String name;
  final int frequency;
  final int progress;
  final String category;

  Habit({
    required this.id,
    required this.name,
    required this.frequency,
    required this.progress,
    required this.category,
  });

  // Method to copy a habit and update some properties
  Habit copyWith({
    String? id,
    String? name,
    int? frequency,
    int? progress,
    String? category,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      frequency: frequency ?? this.frequency,
      progress: progress ?? this.progress,
      category: category ?? this.category,
    );
  }

  // Convert a Habit object into a map for storage or API requests
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'frequency': frequency,
      'progress': progress,
      'category': category,
    };
  }

  // Convert a map into a Habit object
  factory Habit.fromMap(Map<String, dynamic> map) {
    return Habit(
      id: map['id'],
      name: map['name'],
      frequency: map['frequency'],
      progress: map['progress'],
      category: map['category'],
    );
  }
}
