import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssetModel extends ChangeNotifier {
  String _mainBankBalance = '7,000,000';

  String get mainBankBalance => _mainBankBalance;

  void updateMainBankBalance(String newBalance) {
    _mainBankBalance = newBalance;
    notifyListeners();
  }
}

class AssetDetailPage extends StatelessWidget {
  const AssetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final assetModel = Provider.of<AssetModel>(context); // AssetModel 인스턴스 가져오기

    return Scaffold(
      appBar: AppBar(
        title: const Text('자산', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 총 자산
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '심재현 님의 순자산',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    '${assetModel.mainBankBalance}원', // Provider를 통해 잔액 표시
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 계좌 및 현금
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('계좌 · 현금',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('13,345,700원', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 10), // 줄 간격

                    // 입출금 통장 목록
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('입출금',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        Text('300,000원',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10), // 줄 간격
                    _buildAccountRow(
                        '국민은행 입출금 통장', '3,493,520원', Icons.account_balance),
                    const SizedBox(height: 10), // 줄 간격
                    _buildAccountRow(
                        '신한은행 입출금 통장', '1,052,180원', Icons.account_balance),
                    const SizedBox(height: 10), // 줄 간격
                    const Divider(),

                    // 예적금 통장 목록
                    const SizedBox(height: 10), // 줄 간격
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('예적금',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        Text('330,000원',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10), // 줄 간격
                    _buildAccountRow(
                        '우리은행 예적금 통장', '7,000,000원', Icons.account_balance),
                    const SizedBox(height: 10), // 줄 간격
                    _buildDepositAccountRow(
                        '시티은행 예적금 통장', '1,800,000원', Icons.account_balance),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 카드
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('카드',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('100,000원', style: TextStyle(fontSize: 18)),
                            Text('총 미결제 금액', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // 줄 간격

                    // 신용카드 목록
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('신용카드',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        Text('100,000원',
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 10), // 줄 간격
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.credit_card, size: 24),
                            SizedBox(width: 8),
                            Text('국민카드', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('100,000원', style: TextStyle(fontSize: 16)),
                            Text('11월 15일 결제 예정',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // 줄 간격

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.credit_card, size: 24),
                            SizedBox(width: 8),
                            Text('신한카드', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('100,000원', style: TextStyle(fontSize: 16)),
                            Text('11월 30일 결제 예정',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // 줄 간격
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 증권
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('증권',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('?원', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 대출
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('대출',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('?원', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountRow(String bankName, String amount, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Text(bankName, style: const TextStyle(fontSize: 16)),
          ],
        ),
        Text(amount, style: const TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildDepositAccountRow(
      String bankName, String amount, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Text(bankName, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            const Text('만기',
                style: TextStyle(fontSize: 12, color: Colors.yellow)),
          ],
        ),
        Text(amount, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
