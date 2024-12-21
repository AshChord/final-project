import 'package:flutter/material.dart';

class LedgerDetailPage extends StatelessWidget {
  const LedgerDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '총 수입',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '₩ 3,500,000',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '예상 ₩ 3,780,000',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16), // const 제거
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '총 지출',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '₩ 1,570,000',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '예상 ₩ 3,500,000',
                            style: TextStyle(fontSize: 14),
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
            const ListTile(
              title: Text('수입: 월급'),
              subtitle: Text('₩ 3,000,000'),
            ),
            const ListTile(
              title: Text('지출: 식비'),
              subtitle: Text('₩ 200,000'),
            ),
            const ListTile(
              title: Text('지출: 교통비'),
              subtitle: Text('₩ 50,000'),
            ),
            const ListTile(
              title: Text('지출: 유틸리티 요금'),
              subtitle: Text('₩ 150,000'),
            ),
            const ListTile(
              title: Text('지출: 외식비'),
              subtitle: Text('₩ 100,000'),
            ),
            const ListTile(
              title: Text('지출: 쇼핑'),
              subtitle: Text('₩ 300,000'),
            ),
          ],
        ),
      ),
    );
  }
}

// 수입/지출 입력 페이지
class IncomeExpenseInputPage extends StatelessWidget {
  const IncomeExpenseInputPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              '수입 입력',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: '수입 내역',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: '금액',
                border: OutlineInputBorder(),
                prefixText: '₩ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 수입 저장 기능 구현
                Navigator.pop(context); // 입력 후 페이지 닫기
              },
              child: const Text('수입 저장'),
            ),
            const Divider(height: 32),

            // 지출 입력
            const Text(
              '지출 입력',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: '지출 내역',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                labelText: '금액',
                border: OutlineInputBorder(),
                prefixText: '₩ ',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // 지출 저장 기능 구현
                Navigator.pop(context); // 입력 후 페이지 닫기
              },
              child: const Text('지출 저장'),
            ),
          ],
        ),
      ),
    );
  }
}
