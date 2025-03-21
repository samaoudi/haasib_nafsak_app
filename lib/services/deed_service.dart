import 'package:flutter/material.dart';
import '../models/deed.dart';

class DeedService {
  // قائمة الأعمال الصالحة
  static List<Deed> getGoodDeeds() {
    return [
      Deed(id: 'g1', title: 'صلاة الفرض', category: 'prayer', selected: false),
      Deed(id: 'g2', title: 'صلاة النافلة', category: 'prayer', selected: false),
      Deed(id: 'g3', title: 'قراءة القرآن', category: 'quran', selected: false),
      Deed(id: 'g4', title: 'الذكر', category: 'dhikr', selected: false),
      Deed(id: 'g5', title: 'بر الوالدين', category: 'family', selected: false),
      Deed(id: 'g6', title: 'الصدقة', category: 'charity', selected: false),
      Deed(id: 'g7', title: 'مساعدة الناس', category: 'charity', selected: false),
      Deed(id: 'g8', title: 'كفالة يتيم', category: 'charity', selected: false),
      Deed(id: 'g9', title: 'إزالة الأذى', category: 'charity', selected: false),
      Deed(id: 'g10', title: 'صوم (فرض أو تطوع)', category: 'fasting', selected: false),
    ];
  }

  // قائمة الأخطاء والذنوب
  static List<Deed> getBadDeeds() {
    return [
      Deed(id: 'b1', title: 'تأخير الصلاة', category: 'prayer', selected: false),
      Deed(id: 'b2', title: 'الغيبة والنميمة', category: 'speech', selected: false),
      Deed(id: 'b3', title: 'مشاهدة المحرمات', category: 'eyes', selected: false),
      Deed(id: 'b4', title: 'الكذب', category: 'speech', selected: false),
      Deed(id: 'b5', title: 'أذية الآخرين', category: 'behavior', selected: false),
      Deed(id: 'b6', title: 'التقصير في الطاعات', category: 'worship', selected: false),
      Deed(id: 'b7', title: 'الغش', category: 'behavior', selected: false),
      Deed(id: 'b8', title: 'الظلم', category: 'behavior', selected: false),
      Deed(id: 'b9', title: 'سوء الظن', category: 'thought', selected: false),
    ];
  }
}
