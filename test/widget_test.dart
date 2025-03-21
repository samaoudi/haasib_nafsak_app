import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:haasib_nafsak/main.dart';

void main() {
  testWidgets('تطبيق حاسب نفسك - اختبار أساسي', (WidgetTester tester) async {
    // بناء التطبيق
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // التحقق من وجود الشاشة الرئيسية
    expect(find.text('حاسب نفسك'), findsOneWidget);
    expect(find.text('ابدأ محاسبة اليوم'), findsOneWidget);
    
    // اختبار أساسي ناجح
    expect(true, true);
  });
}
