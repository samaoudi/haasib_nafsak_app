import 'package:flutter/material.dart';
import 'bad_deeds_screen.dart';

class GoodDeedsScreen extends StatefulWidget {
  const GoodDeedsScreen({super.key});

  @override
  State<GoodDeedsScreen> createState() => _GoodDeedsScreenState();
}

class _GoodDeedsScreenState extends State<GoodDeedsScreen> {
  final List<Map<String, dynamic>> goodDeeds = [
    {'title': 'صلاة الفرض', 'selected': false},
    {'title': 'صلاة النافلة', 'selected': false},
    {'title': 'قراءة القرآن', 'selected': false},
    {'title': 'الذكر', 'selected': false},
    {'title': 'بر الوالدين', 'selected': false},
    {'title': 'الصدقة', 'selected': false},
    {'title': 'مساعدة الناس', 'selected': false},
    {'title': 'كفالة يتيم', 'selected': false},
    {'title': 'إزالة الأذى', 'selected': false},
    {'title': 'صوم (فرض أو تطوع)', 'selected': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الأعمال الصالحة'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'حدد الأعمال الصالحة التي قمت بها اليوم:',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: goodDeeds.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: CheckboxListTile(
                    title: Text(
                      goodDeeds[index]['title'],
                      style: const TextStyle(fontSize: 16),
                    ),
                    value: goodDeeds[index]['selected'],
                    activeColor: Colors.green,
                    onChanged: (bool? value) {
                      setState(() {
                        goodDeeds[index]['selected'] = value;
                      });
                    },
                    secondary: CircleAvatar(
                      backgroundColor: Colors.green.shade100,
                      child: Icon(
                        Icons.check_circle,
                        color: goodDeeds[index]['selected'] ? Colors.green : Colors.grey.shade400,
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
                  MaterialPageRoute(builder: (context) => const BadDeedsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'التالي',
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
