class DailyAdvice {
  final String id;
  final String text;
  final String category; // e.g., 'general', 'prayer', 'charity', etc.
  final DateTime date;

  DailyAdvice({
    required this.id,
    required this.text,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  factory DailyAdvice.fromJson(Map<String, dynamic> json) {
    return DailyAdvice(
      id: json['id'],
      text: json['text'],
      category: json['category'],
      date: DateTime.parse(json['date']),
    );
  }
}
