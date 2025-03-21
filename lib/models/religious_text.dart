class ReligiousText {
  final String id;
  final String text;
  final String source;
  final String type; // 'verse' for Quran verses, 'hadith' for Hadiths
  final List<String> tags; // Tags for categorization (e.g., 'prayer', 'charity', etc.)

  ReligiousText({
    required this.id,
    required this.text,
    required this.source,
    required this.type,
    required this.tags,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'source': source,
      'type': type,
      'tags': tags,
    };
  }

  factory ReligiousText.fromJson(Map<String, dynamic> json) {
    return ReligiousText(
      id: json['id'],
      text: json['text'],
      source: json['source'],
      type: json['type'],
      tags: List<String>.from(json['tags']),
    );
  }
}
