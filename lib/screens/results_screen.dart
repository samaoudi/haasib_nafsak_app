import 'package:flutter/material.dart';
import 'statistics_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نتيجة المحاسبة'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قسم الأعمال الصالحة
              _buildSectionTitle(context, 'الأعمال الصالحة', Colors.green),
              const SizedBox(height: 10),
              _buildQuoteCard(
                'قال تعالى: "إِنَّ الْحَسَنَاتِ يُذْهِبْنَ السَّيِّئَاتِ"',
                'سورة هود: 114',
                Colors.green.shade50,
                Colors.green,
              ),
              const SizedBox(height: 15),
              _buildAdviceCard(
                'أحسنت! استمر في المحافظة على الصلوات وقراءة القرآن',
                Colors.green.shade100,
                Icons.thumb_up,
              ),
              
              const SizedBox(height: 30),
              
              // قسم الأخطاء والذنوب
              _buildSectionTitle(context, 'الأخطاء والذنوب', Colors.red.shade700),
              const SizedBox(height: 10),
              _buildQuoteCard(
                'قال رسول الله ﷺ: "التائب من الذنب كمن لا ذنب له"',
                'رواه ابن ماجه',
                Colors.red.shade50,
                Colors.red.shade700,
              ),
              const SizedBox(height: 15),
              _buildAdviceCard(
                'استغفر الله وتب إليه، وحاول تجنب الغيبة والنميمة',
                Colors.red.shade100,
                Icons.healing,
              ),
              
              const SizedBox(height: 30),
              
              // نصيحة يومية
              _buildSectionTitle(context, 'نصيحة اليوم', Colors.blue.shade700),
              const SizedBox(height: 10),
              _buildQuoteCard(
                'قال رسول الله ﷺ: "حاسبوا أنفسكم قبل أن تحاسبوا"',
                'رواه الترمذي',
                Colors.blue.shade50,
                Colors.blue.shade700,
              ),
              const SizedBox(height: 15),
              _buildAdviceCard(
                'تذكر أن محاسبة النفس هي أول خطوات التغيير والإصلاح',
                Colors.blue.shade100,
                Icons.lightbulb,
              ),
              
              const SizedBox(height: 30),
              
              // زر الإحصائيات
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StatisticsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'عرض الإحصائيات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildQuoteCard(String quote, String source, Color bgColor, Color textColor) {
    return Card(
      color: bgColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quote,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              source,
              style: TextStyle(
                fontSize: 14,
                color: textColor.withOpacity(0.8),
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceCard(String advice, Color bgColor, IconData icon) {
    return Card(
      color: bgColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey.shade800,
              size: 28,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                advice,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
