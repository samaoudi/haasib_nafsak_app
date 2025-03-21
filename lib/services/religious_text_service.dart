import '../models/religious_text.dart';

class ReligiousTextService {
  // آيات قرآنية مرتبطة بالأعمال الصالحة
  static List<ReligiousText> getVerses() {
    return [
      ReligiousText(
        id: 'v1',
        text: 'إِنَّ الْحَسَنَاتِ يُذْهِبْنَ السَّيِّئَاتِ',
        source: 'سورة هود: 114',
        type: 'verse',
        tags: ['good_deeds', 'forgiveness'],
      ),
      ReligiousText(
        id: 'v2',
        text: 'وَأَقِمِ الصَّلَاةَ إِنَّ الصَّلَاةَ تَنْهَى عَنِ الْفَحْشَاءِ وَالْمُنْكَرِ',
        source: 'سورة العنكبوت: 45',
        type: 'verse',
        tags: ['prayer', 'good_behavior'],
      ),
      ReligiousText(
        id: 'v3',
        text: 'وَمَن يَعْمَلْ مِثْقَالَ ذَرَّةٍ خَيْرًا يَرَهُ',
        source: 'سورة الزلزلة: 7',
        type: 'verse',
        tags: ['good_deeds', 'reward'],
      ),
      ReligiousText(
        id: 'v4',
        text: 'وَأَنفِقُوا فِي سَبِيلِ اللَّهِ وَلَا تُلْقُوا بِأَيْدِيكُمْ إِلَى التَّهْلُكَةِ',
        source: 'سورة البقرة: 195',
        type: 'verse',
        tags: ['charity', 'spending'],
      ),
      ReligiousText(
        id: 'v5',
        text: 'وَقَضَى رَبُّكَ أَلَّا تَعْبُدُوا إِلَّا إِيَّاهُ وَبِالْوَالِدَيْنِ إِحْسَانًا',
        source: 'سورة الإسراء: 23',
        type: 'verse',
        tags: ['parents', 'family'],
      ),
    ];
  }

  // أحاديث نبوية مرتبطة بالأعمال الصالحة والأخطاء
  static List<ReligiousText> getHadiths() {
    return [
      ReligiousText(
        id: 'h1',
        text: 'التائب من الذنب كمن لا ذنب له',
        source: 'رواه ابن ماجه',
        type: 'hadith',
        tags: ['repentance', 'forgiveness'],
      ),
      ReligiousText(
        id: 'h2',
        text: 'حاسبوا أنفسكم قبل أن تحاسبوا',
        source: 'رواه الترمذي',
        type: 'hadith',
        tags: ['self_accountability', 'judgment'],
      ),
      ReligiousText(
        id: 'h3',
        text: 'من حسن إسلام المرء تركه ما لا يعنيه',
        source: 'رواه الترمذي',
        type: 'hadith',
        tags: ['good_behavior', 'focus'],
      ),
      ReligiousText(
        id: 'h4',
        text: 'الصلاة عمود الدين، من أقامها فقد أقام الدين، ومن هدمها فقد هدم الدين',
        source: 'رواه البيهقي',
        type: 'hadith',
        tags: ['prayer', 'worship'],
      ),
      ReligiousText(
        id: 'h5',
        text: 'من قرأ حرفاً من كتاب الله فله به حسنة، والحسنة بعشر أمثالها',
        source: 'رواه الترمذي',
        type: 'hadith',
        tags: ['quran', 'reward'],
      ),
      ReligiousText(
        id: 'h6',
        text: 'الصدقة تطفئ الخطيئة كما يطفئ الماء النار',
        source: 'رواه الترمذي',
        type: 'hadith',
        tags: ['charity', 'forgiveness'],
      ),
      ReligiousText(
        id: 'h7',
        text: 'من كان يؤمن بالله واليوم الآخر فليقل خيراً أو ليصمت',
        source: 'متفق عليه',
        type: 'hadith',
        tags: ['speech', 'silence'],
      ),
    ];
  }

  // الحصول على نص ديني مناسب لفئة معينة
  static List<ReligiousText> getTextsByCategory(String category) {
    List<ReligiousText> allTexts = [...getVerses(), ...getHadiths()];
    return allTexts.where((text) => text.tags.contains(category)).toList();
  }

  // الحصول على نص ديني عشوائي مناسب للأعمال الصالحة
  static ReligiousText getRandomGoodDeedText() {
    List<ReligiousText> goodTexts = getTextsByCategory('good_deeds');
    goodTexts.addAll(getTextsByCategory('reward'));
    
    // اختيار نص عشوائي
    goodTexts.shuffle();
    return goodTexts.first;
  }

  // الحصول على نص ديني عشوائي مناسب للتوبة والاستغفار
  static ReligiousText getRandomRepentanceText() {
    List<ReligiousText> repentanceTexts = getTextsByCategory('repentance');
    repentanceTexts.addAll(getTextsByCategory('forgiveness'));
    
    // اختيار نص عشوائي
    repentanceTexts.shuffle();
    return repentanceTexts.first;
  }
}
