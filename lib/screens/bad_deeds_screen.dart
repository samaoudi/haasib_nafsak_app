import 'package:flutter/material.dart';
import 'results_screen.dart';

class BadDeedsScreen extends StatefulWidget {
  const BadDeedsScreen({super.key});

  @override
  State<BadDeedsScreen> createState() => _BadDeedsScreenState();
}

class _BadDeedsScreenState extends State<BadDeedsScreen> {
  final List<Map<String, dynamic>> badDeeds = [
    {'title': 'تأخير الصلاة', 'selected': false},
    {'title': 'الغيبة والنميمة', 'selected': false},
    {'title': 'مشاهدة المحرمات', 'selected': false},
    {'title': 'الكذب', 'selected': false},
    {'title': 'أذية الآخرين', 'selected': false},
    {'title': 'التقصير في الطاعات', 'selected': false},
    {'title': 'الغش', 'selected': false},
    {'title': 'الظلم', 'selected': false},
    {'title': 'سوء الظن', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأخطاء والذنوب'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'حدد الأخطاء التي وقعت فيها اليوم:',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: badDeeds.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CheckboxListTile(
                    title: Text(
                      badDeeds[index]['title'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    value: badDeeds[index]['selected'],
                    activeColor: Colors.red.shade700,
                    onChanged: (bool? value) {
                      setState(() {
                        badDeeds[index]['selected'] = value;
                      });
                    },
                    secondary: CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: badDeeds[index]['selected'] ? Colors.red.shade700 : Colors.grey.shade400,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResultsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'عرض النتيجة',
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
    );
  }
}
