import 'dart:math';
import '../models/daily_record.dart';
import '../models/deed.dart';

class StatisticsService {
  // حساب إجمالي الأعمال الصالحة في فترة زمنية محددة
  static int countGoodDeeds(List<DailyRecord> records, {DateTime? startDate, DateTime? endDate}) {
    int count = 0;
    
    for (var record in records) {
      if ((startDate == null || record.date.isAfter(startDate)) && 
          (endDate == null || record.date.isBefore(endDate.add(const Duration(days: 1))))) {
        count += record.goodDeedIds.length;
      }
    }
    
    return count;
  }

  // حساب إجمالي الأخطاء في فترة زمنية محددة
  static int countBadDeeds(List<DailyRecord> records, {DateTime? startDate, DateTime? endDate}) {
    int count = 0;
    
    for (var record in records) {
      if ((startDate == null || record.date.isAfter(startDate)) && 
          (endDate == null || record.date.isBefore(endDate.add(const Duration(days: 1))))) {
        count += record.badDeedIds.length;
      }
    }
    
    return count;
  }

  // حساب نسبة التحسن مقارنة بالأسبوع السابق
  static double calculateImprovement(List<DailyRecord> currentWeekRecords, List<DailyRecord> previousWeekRecords) {
    if (previousWeekRecords.isEmpty) {
      return 0.0;
    }
    
    int currentGoodDeeds = countGoodDeeds(currentWeekRecords);
    int currentBadDeeds = countBadDeeds(currentWeekRecords);
    int previousGoodDeeds = countGoodDeeds(previousWeekRecords);
    int previousBadDeeds = countBadDeeds(previousWeekRecords);
    
    // حساب النسبة بناءً على زيادة الأعمال الصالحة وانخفاض الأخطاء
    double goodDeedsImprovement = previousGoodDeeds > 0 
        ? (currentGoodDeeds - previousGoodDeeds) / previousGoodDeeds 
        : (currentGoodDeeds > 0 ? 1.0 : 0.0);
    
    double badDeedsImprovement = previousBadDeeds > 0 
        ? (previousBadDeeds - currentBadDeeds) / previousBadDeeds 
        : (currentBadDeeds == 0 ? 1.0 : 0.0);
    
    // متوسط التحسن
    double averageImprovement = (goodDeedsImprovement + badDeedsImprovement) / 2;
    
    // تحويل النسبة إلى قيمة بين 0 و 1
    return min(max(averageImprovement, 0.0), 1.0);
  }

  // الحصول على العمل الصالح الأكثر تكراراً
  static String getMostFrequentGoodDeed(List<DailyRecord> records, List<Deed> goodDeeds) {
    if (records.isEmpty) {
      return "لا توجد بيانات كافية";
    }
    
    Map<String, int> deedCounts = {};
    
    for (var record in records) {
      for (var deedId in record.goodDeedIds) {
        deedCounts[deedId] = (deedCounts[deedId] ?? 0) + 1;
      }
    }
    
    if (deedCounts.isEmpty) {
      return "لا توجد أعمال صالحة مسجلة";
    }
    
    // العثور على العمل الأكثر تكراراً
    String mostFrequentDeedId = deedCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    
    // الحصول على عنوان العمل
    Deed? deed = goodDeeds.firstWhere(
      (d) => d.id == mostFrequentDeedId,
      orElse: () => Deed(id: '', title: 'غير معروف', category: ''),
    );
    
    return deed.title;
  }

  // الحصول على الخطأ الأكثر تكراراً
  static String getMostFrequentBadDeed(List<DailyRecord> records, List<Deed> badDeeds) {
    if (records.isEmpty) {
      return "لا توجد بيانات كافية";
    }
    
    Map<String, int> deedCounts = {};
    
    for (var record in records) {
      for (var deedId in record.badDeedIds) {
        deedCounts[deedId] = (deedCounts[deedId] ?? 0) + 1;
      }
    }
    
    if (deedCounts.isEmpty) {
      return "لا توجد أخطاء مسجلة";
    }
    
    // العثور على الخطأ الأكثر تكراراً
    String mostFrequentDeedId = deedCounts.entries
        .reduce((a, b) => a.value > b.value ? a : b)
        .key;
    
    // الحصول على عنوان الخطأ
    Deed? deed = badDeeds.firstWhere(
      (d) => d.id == mostFrequentDeedId,
      orElse: () => Deed(id: '', title: 'غير معروف', category: ''),
    );
    
    return deed.title;
  }

  // الحصول على بيانات الرسم البياني للأسبوع
  static List<Map<String, dynamic>> getWeeklyChartData(List<DailyRecord> records) {
    // تحديد تاريخ بداية الأسبوع (السبت)
    DateTime now = DateTime.now();
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    startOfWeek = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    
    List<Map<String, dynamic>> chartData = [];
    
    // إنشاء بيانات لكل يوم من أيام الأسبوع
    for (int i = 0; i < 7; i++) {
      DateTime currentDay = startOfWeek.add(Duration(days: i));
      
      // البحث عن سجل اليوم
      List<DailyRecord> dayRecords = records.where(
        (record) => record.date.year == currentDay.year && 
                    record.date.month == currentDay.month && 
                    record.date.day == currentDay.day
      ).toList();
      
      int goodDeedsCount = 0;
      int badDeedsCount = 0;
      
      if (dayRecords.isNotEmpty) {
        for (var record in dayRecords) {
          goodDeedsCount += record.goodDeedIds.length;
          badDeedsCount += record.badDeedIds.length;
        }
      }
      
      chartData.add({
        'day': i,
        'goodDeeds': goodDeedsCount,
        'badDeeds': badDeedsCount,
      });
    }
    
    return chartData;
  }
}
