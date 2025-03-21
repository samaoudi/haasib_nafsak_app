import '../models/daily_advice.dart';

class DailyAdviceService {
  // قائمة النصائح اليومية
  static List<DailyAdvice> getAllAdvice() {
    return [
      DailyAdvice(
        id: 'a1',
        text: 'تذكر أن محاسبة النفس هي أول خطوات التغيير والإصلاح',
        category: 'general',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a2',
        text: 'حافظ على صلاتك في وقتها، فهي أول ما يُسأل عنه العبد يوم القيامة',
        category: 'prayer',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a3',
        text: 'اجعل لك ورداً يومياً من القرآن، ولو كان قليلاً',
        category: 'quran',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a4',
        text: 'احرص على الاستغفار، فهو يمحو الذنوب ويجلب الرزق',
        category: 'repentance',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a5',
        text: 'تصدق ولو بالقليل، فإن الصدقة تطفئ غضب الرب',
        category: 'charity',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a6',
        text: 'بر والديك واحسن إليهما، فرضاهما من رضا الله',
        category: 'family',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a7',
        text: 'احفظ لسانك من الغيبة والنميمة، فهما من كبائر الذنوب',
        category: 'speech',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a8',
        text: 'أكثر من ذكر الله في كل وقت، فهو جلاء القلوب',
        category: 'dhikr',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a9',
        text: 'أحسن الظن بالناس، فسوء الظن يفسد العلاقات',
        category: 'thought',
        date: DateTime.now(),
      ),
      DailyAdvice(
        id: 'a10',
        text: 'كن صادقاً في أقوالك وأفعالك، فالصدق منجاة',
        category: 'behavior',
        date: DateTime.now(),
      ),
    ];
  }

  // الحصول على نصيحة يومية عشوائية
  static DailyAdvice getRandomDailyAdvice() {
    List<DailyAdvice> allAdvice = getAllAdvice();
    allAdvice.shuffle();
    return allAdvice.first;
  }

  // الحصول على نصيحة مناسبة لفئة معينة
  static DailyAdvice getAdviceByCategory(String category) {
    List<DailyAdvice> filteredAdvice = getAllAdvice()
        .where((advice) => advice.category == category)
        .toList();
    
    if (filteredAdvice.isEmpty) {
      return getRandomDailyAdvice();
    }
    
    filteredAdvice.shuffle();
    return filteredAdvice.first;
  }
}
