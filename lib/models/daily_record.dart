class DailyRecord {
  final String id;
  final DateTime date;
  final List<String> goodDeedIds;
  final List<String> badDeedIds;
  final String? adviceId;
  final List<String>? religiousTextIds;

  DailyRecord({
    required this.id,
    required this.date,
    required this.goodDeedIds,
    required this.badDeedIds,
    this.adviceId,
    this.religiousTextIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'goodDeedIds': goodDeedIds,
      'badDeedIds': badDeedIds,
      'adviceId': adviceId,
      'religiousTextIds': religiousTextIds,
    };
  }

  factory DailyRecord.fromJson(Map<String, dynamic> json) {
    return DailyRecord(
      id: json['id'],
      date: DateTime.parse(json['date']),
      goodDeedIds: List<String>.from(json['goodDeedIds']),
      badDeedIds: List<String>.from(json['badDeedIds']),
      adviceId: json['adviceId'],
      religiousTextIds: json['religiousTextIds'] != null 
          ? List<String>.from(json['religiousTextIds']) 
          : null,
    );
  }
}
