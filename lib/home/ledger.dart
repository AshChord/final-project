import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ledger_provider.dart'; // LedgerProvider import

class LedgerDetailPage extends StatelessWidget {
  const LedgerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ledgerProvider = Provider.of<LedgerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '가계부',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 총 수입 / 총 지출 카드
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '총 수입',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₩ ${ledgerProvider.totalIncome.toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '총 지출',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '₩ ${ledgerProvider.totalExpense.toStringAsFixed(0)}',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 수입/지출 입력 페이지로 이동 버튼
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IncomeExpenseInputPage()),
                );
              },
              child: const Text('수입/지출 입력하기'),
            ),
            const Divider(height: 32),

            // 기록된 내역 리스트
            const Text(
              '기록된 내역',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ledgerProvider.records.isEmpty
                ? const Text('기록된 내역이 없습니다.')
                : Column(
              children: ledgerProvider.records.map((record) {
                return ListTile(
                  title: Text(
                    '${record['type'] == 'income' ? '수입' : '지출'}: ${record['description']}',
                  ),
                  subtitle: Text('₩ ${record['amount']}'),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeExpenseInputPage extends StatelessWidget {
  const IncomeExpenseInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final ledgerProvider = Provider.of<LedgerProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '수입/지출 입력',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 수입 입력
            const Text(
              '내역 입력',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: '내역',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: '금액',
                border: OutlineInputBorder(),
                prefixText: '₩ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String description = descriptionController.text;
                double? amount = double.tryParse(amountController.text);

                if (description.isNotEmpty && amount != null) {
                  ledgerProvider.addIncome(description, amount);
                  Navigator.pop(context);
                }
              },
              child: const Text('수입 저장'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String description = descriptionController.text;
                double? amount = double.tryParse(amountController.text);

                if (description.isNotEmpty && amount != null) {
                  ledgerProvider.addExpense(description, amount);
                  Navigator.pop(context);
                }
              },
              child: const Text('지출 저장'),
            ),
          ],
        ),
      ),
    );
  }
}
