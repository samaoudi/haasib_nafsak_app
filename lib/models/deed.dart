class Deed {
  final String id;
  final String title;
  final String category;
  bool selected;

  Deed({
    required this.id,
    required this.title,
    required this.category,
    this.selected = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'selected': selected,
    };
  }

  factory Deed.fromJson(Map<String, dynamic> json) {
    return Deed(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      selected: json['selected'] ?? false,
    );
  }
}
