import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'home_screen.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإحصائيات'),
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // عنوان الإحصائيات
              Center(
                child: Text(
                  'إحصائيات الأسبوع',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // بطاقة الرسم البياني
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الأعمال الصالحة مقابل الأخطاء',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: _buildBarChart(),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendItem('الأعمال الصالحة', Colors.green),
                          const SizedBox(width: 20),
                          _buildLegendItem('الأخطاء', Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // بطاقة التقدم
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مستوى التحسن',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 20),
                      const LinearProgressIndicator(
                        value: 0.7,
                        minHeight: 10,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                      ),
                      const SizedBox(height: 10),
                      const Center(
                        child: Text(
                          '70% تحسن مقارنة بالأسبوع الماضي',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // بطاقة الإحصائيات العامة
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'إحصائيات عامة',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 15),
                      _buildStatItem('إجمالي الأعمال الصالحة هذا الأسبوع', '23', Colors.green),
                      const Divider(),
                      _buildStatItem('إجمالي الأخطاء هذا الأسبوع', '12', Colors.red),
                      const Divider(),
                      _buildStatItem('أكثر عمل صالح تكراراً', 'الصلاة', Colors.green),
                      const Divider(),
                      _buildStatItem('أكثر خطأ تكراراً', 'تأخير الصلاة', Colors.red),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // زر العودة للصفحة الرئيسية
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade700,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'العودة للصفحة الرئيسية',
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

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(
          enabled: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const style = TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                String text;
                switch (value.toInt()) {
                  case 0:
                    text = 'السبت';
                    break;
                  case 1:
                    text = 'الأحد';
                    break;
                  case 2:
                    text = 'الإثنين';
                    break;
                  case 3:
                    text = 'الثلاثاء';
                    break;
                  case 4:
                    text = 'الأربعاء';
                    break;
                  case 5:
                    text = 'الخميس';
                    break;
                  case 6:
                    text = 'الجمعة';
                    break;
                  default:
                    text = '';
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(text, style: style),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value == 0) {
                  return const SideTitleWidget(
                    axisSide: AxisSide.left,
                    child: Text('0'),
                  );
                }
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: [
          _buildBarGroup(0, 5, 2),
          _buildBarGroup(1, 7, 3),
          _buildBarGroup(2, 4, 4),
          _buildBarGroup(3, 6, 1),
          _buildBarGroup(4, 8, 2),
          _buildBarGroup(5, 5, 3),
          _buildBarGroup(6, 9, 1),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double goodDeeds, double badDeeds) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: goodDeeds,
          color: Colors.green,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
        BarChartRodData(
          toY: badDeeds,
          color: Colors.red,
          width: 12,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
