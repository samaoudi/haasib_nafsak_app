import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/daily_record.dart';
import '../models/deed.dart';
import '../services/deed_service.dart';
import '../services/religious_text_service.dart';
import '../services/daily_advice_service.dart';
import '../services/storage_service.dart';

class AccountabilityService {
  static final uuid = Uuid();
  
  // إنشاء سجل يومي جديد
  static Future<DailyRecord> createDailyRecord(List<Deed> selectedGoodDeeds, List<Deed> selectedBadDeeds) async {
    // استخراج معرفات الأعمال الصالحة المحددة
    final goodDeedIds = selectedGoodDeeds
        .where((deed) => deed.selected)
        .map((deed) => deed.id)
        .toList();
    
    // استخراج معرفات الأخطاء المحددة
    final badDeedIds = selectedBadDeeds
        .where((deed) => deed.selected)
        .map((deed) => deed.id)
        .toList();
    
    // الحصول على نصيحة يومية عشوائية
    final dailyAdvice = DailyAdviceService.getRandomDailyAdvice();
    
    // الحصول على نصوص دينية مناسبة
    final List<String> religiousTextIds = [];
    
    if (goodDeedIds.isNotEmpty) {
      religiousTextIds.add(ReligiousTextService.getRandomGoodDeedText().id);
    }
    
    if (badDeedIds.isNotEmpty) {
      religiousTextIds.add(ReligiousTextService.getRandomRepentanceText().id);
    }
    
    // إنشاء سجل جديد
    final dailyRecord = DailyRecord(
      id: uuid.v4(),
      date: DateTime.now(),
      goodDeedIds: goodDeedIds,
      badDeedIds: badDeedIds,
      adviceId: dailyAdvice.id,
      religiousTextIds: religiousTextIds,
    );
    
    // حفظ السجل في التخزين المحلي
    await StorageService.saveDailyRecord(dailyRecord);
    
    return dailyRecord;
  }
  
  // الحصول على سجلات الأسبوع الحالي
  static Future<List<DailyRecord>> getCurrentWeekRecords() async {
    final allRecords = await StorageService.getDailyRecords();
    
    // تحديد تاريخ بداية الأسبوع (السبت)
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday % 7));
    final startDate = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    
    // تحديد تاريخ نهاية الأسبوع (الجمعة)
    final endDate = startDate.add(const Duration(days: 6));
    
    // تصفية السجلات للأسبوع الحالي
    return allRecords.where((record) {
      return record.date.isAfter(startDate.subtract(const Duration(days: 1))) && 
             record.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }
  
  // الحصول على سجلات الأسبوع السابق
  static Future<List<DailyRecord>> getPreviousWeekRecords() async {
    final allRecords = await StorageService.getDailyRecords();
    
    // تحديد تاريخ بداية الأسبوع الحالي (السبت)
    final now = DateTime.now();
    final startOfCurrentWeek = now.subtract(Duration(days: now.weekday % 7));
    final startCurrentDate = DateTime(startOfCurrentWeek.year, startOfCurrentWeek.month, startOfCurrentWeek.day);
    
    // تحديد تاريخ بداية الأسبوع السابق
    final startOfPreviousWeek = startCurrentDate.subtract(const Duration(days: 7));
    
    // تحديد تاريخ نهاية الأسبوع السابق
    final endOfPreviousWeek = startCurrentDate.subtract(const Duration(days: 1));
    
    // تصفية السجلات للأسبوع السابق
    return allRecords.where((record) {
      return record.date.isAfter(startOfPreviousWeek.subtract(const Duration(days: 1))) && 
             record.date.isBefore(endOfPreviousWeek.add(const Duration(days: 1)));
    }).toList();
  }
  
  // إعادة تعيين حالة الأعمال (لإعادة الاستخدام)
  static List<Deed> resetDeedsSelection(List<Deed> deeds) {
    return deeds.map((deed) => Deed(
      id: deed.id,
      title: deed.title,
      category: deed.category,
      selected: false,
    )).toList();
  }
}
