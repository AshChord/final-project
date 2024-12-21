import 'package:flutter/material.dart';

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
            // 예산 계획 섹션
            _buildBudgetPlanSection(),
            const SizedBox(height: 16),

            // 저축 목표 섹션
            _buildSavingsGoalSection(),
            const SizedBox(height: 16),

            // 분석 및 피드백 섹션
            _buildAnalysisFeedbackSection(),
            const SizedBox(height: 16),

            // 재무 습관 개선 팁 섹션
            _buildFinancialTipsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetPlanSection() {
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
            _buildBudgetInputField('식비'),
            _buildBudgetInputField('교통비'),
            _buildBudgetInputField('엔터테인먼트'),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetInputField(String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              category,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: '예산 금액',
                prefixText: '₩ ',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              style: TextStyle(),
              keyboardType: TextInputType.number,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsGoalSection() {
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
                '저축 목표',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: '목표 금액',
                prefixText: '₩ ',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              style: TextStyle(),
              keyboardType: TextInputType.number,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    // 목표 설정 기능
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
              '1. 식사 계획을 세우세요. \n2. 대중교통을 활용하세요. \n3. 불필요한 소비를 줄이세요.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
