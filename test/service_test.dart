import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haasib_nafsak/services/deed_service.dart';
import 'package:haasib_nafsak/services/religious_text_service.dart';
import 'package:haasib_nafsak/services/daily_advice_service.dart';
import 'package:haasib_nafsak/services/storage_service.dart';
import 'package:haasib_nafsak/services/accountability_service.dart';

void main() {
  group('اختبار خدمات التطبيق', () {
    test('اختبار خدمة الأعمال', () {
      final goodDeeds = DeedService.getGoodDeeds();
      final badDeeds = DeedService.getBadDeeds();
      
      // التحقق من وجود الأعمال الصالحة
      expect(goodDeeds.isNotEmpty, true);
      expect(goodDeeds.length, 10);
      expect(goodDeeds.first.title, 'صلاة الفرض');
      
      // التحقق من وجود الأخطاء
      expect(badDeeds.isNotEmpty, true);
      expect(badDeeds.length, 9);
      expect(badDeeds.first.title, 'تأخير الصلاة');
    });
    
    test('اختبار خدمة النصوص الدينية', () {
      final verses = ReligiousTextService.getVerses();
      final hadiths = ReligiousTextService.getHadiths();
      
      // التحقق من وجود الآيات
      expect(verses.isNotEmpty, true);
      expect(verses.length, 5);
      
      // التحقق من وجود الأحاديث
      expect(hadiths.isNotEmpty, true);
      expect(hadiths.length, 7);
      
      // اختبار الحصول على نص عشوائي
      final randomGoodText = ReligiousTextService.getRandomGoodDeedText();
      expect(randomGoodText, isNotNull);
      
      final randomRepentanceText = ReligiousTextService.getRandomRepentanceText();
      expect(randomRepentanceText, isNotNull);
    });
    
    test('اختبار خدمة النصائح اليومية', () {
      final allAdvice = DailyAdviceService.getAllAdvice();
      
      // التحقق من وجود النصائح
      expect(allAdvice.isNotEmpty, true);
      expect(allAdvice.length, 10);
      
      // اختبار الحصول على نصيحة عشوائية
      final randomAdvice = DailyAdviceService.getRandomDailyAdvice();
      expect(randomAdvice, isNotNull);
      
      // اختبار الحصول على نصيحة حسب الفئة
      final prayerAdvice = DailyAdviceService.getAdviceByCategory('prayer');
      expect(prayerAdvice, isNotNull);
      expect(prayerAdvice.category, 'prayer');
    });
  });
}
