import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../budget_provider.dart';

class GoalsDetailPage extends StatelessWidget {
  const GoalsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '목표 설정',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 예산 계획
            _buildBudgetPlanSection(context),
            const SizedBox(height: 16),

            // 저축 목표
            _buildSavingsGoalSection(context),
            const SizedBox(height: 16),

            // 분석 및 피드백
            _buildAnalysisFeedbackSection(),
            const SizedBox(height: 16),

            // 재무 습관 개선 팁
            _buildFinancialTipsSection(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildSavingsGoalSection(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);
    final TextEditingController goalController = TextEditingController(
      text: budgetProvider.savingsGoal > 0
          ? budgetProvider.savingsGoal.toStringAsFixed(0)
          : '',
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '저축 목표',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: goalController,
              decoration: const InputDecoration(
                labelText: '목표 금액 입력',
                prefixText: '₩ ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    final enteredValue =
                        double.tryParse(goalController.text) ?? 0.0;
                    if (enteredValue > 0) {
                      budgetProvider.setSavingsGoal(enteredValue);
                    }
                  },
                  child: const Text('목표 설정'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetPlanSection(BuildContext context) {
    final budgetProvider = Provider.of<BudgetProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '예산 계획',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: budgetProvider.budgets.entries
                  .map((entry) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.key,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: entry.value.toString(),
                                decoration: const InputDecoration(
                                  labelText: '예산 금액',
                                  prefixText: '₩ ',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  final amount = double.tryParse(value) ?? 0;
                                  budgetProvider.addBudget(entry.key, amount);
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  budgetProvider.removeCategory(entry.key),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => _showAddCategoryDialog(context),
                  child: const Text('예산 계획 추가'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalysisFeedbackSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '분석 및 피드백',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '현재 지출 패턴 분석: 당신은 식비에서 평균 30%를 초과 지출하고 있습니다. 예산을 조정하세요!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialTipsSection() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '재무 습관 개선 팁',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '1. 식사 계획을 세우세요.\n2. 대중교통을 활용하세요.\n3. 불필요한 소비를 줄이세요.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context) {
    final categoryController = TextEditingController();
    final budgetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('예산 계획 추가'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: '카테고리 이름(예: 식비)'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: budgetController,
                decoration: const InputDecoration(labelText: '예산 금액'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                final category = categoryController.text.trim();
                final amount = double.tryParse(budgetController.text) ?? 0;
                if (category.isNotEmpty) {
                  Provider.of<BudgetProvider>(context, listen: false)
                      .addBudget(category, amount);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }
}
