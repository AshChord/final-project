import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http; // http 패키지 임포트
import 'dart:convert'; // JSON 처리

class AssetModel extends ChangeNotifier {
  String _mainBankBalance = '';
  List<Account> _accounts = [];
  List<CreditCard> _creditCards = [];

  String get mainBankBalance => _mainBankBalance;
  List<Account> get accounts => _accounts;
  List<CreditCard> get creditCards => _creditCards;

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://gist.githubusercontent.com/AshChord/bcfe94f989abfbaa205efe311dcf7117/raw/0692b51ec9693404a3a991b2c22001f4422a6de1/balance.json'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _mainBankBalance = data['assets']['mainBankBalance'];

      // 계좌 데이터 파싱
      _accounts = (data['assets']['accounts'] as List)
          .map((account) => Account.fromJson(account))
          .toList();

      // 카드 데이터 파싱
      _creditCards = (data['assets']['creditCards'] as List)
          .map((card) => CreditCard.fromJson(card))
          .toList();

      notifyListeners();
    } else {
      throw Exception('Failed to load asset data');
    }
  }
}

class Account {
  final String bankName;
  final String amount;

  Account(this.bankName, this.amount);

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(json['bankName'], json['amount']);
  }
}

class CreditCard {
  final String cardName;
  final String amount;
  final String dueDate;

  CreditCard(this.cardName, this.amount, this.dueDate);

  factory CreditCard.fromJson(Map<String, dynamic> json) {
    return CreditCard(json['cardName'], json['amount'], json['dueDate']);
  }
}

class AssetDetailPage extends StatefulWidget {
  const AssetDetailPage({super.key});

  @override
  _AssetDetailPageState createState() => _AssetDetailPageState();
}

class _AssetDetailPageState extends State<AssetDetailPage> {
  @override
  void initState() {
    super.initState();
    // 데이터 로딩
    Provider.of<AssetModel>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final assetModel = Provider.of<AssetModel>(context); // AssetModel 인스턴스 가져오기

    return Scaffold(
      appBar: AppBar(
        title: const Text('자산', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: assetModel.mainBankBalance.isEmpty && assetModel.creditCards.isEmpty
          ? Center(child: CircularProgressIndicator()) // 로딩 중
          : SingleChildScrollView(
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '심재현 님의 순자산',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const Text(
                          '13,145,700원',
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('13,345,700원',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 10), // 줄 간격

                          // 입출금 통장 목록
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('입출금',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Text('4,545,700원',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 10), // 줄 간격
                          for (var account in assetModel.accounts
                              .where((acc) => acc.bankName.contains('입출금')))
                            _buildAccountRow(account.bankName, account.amount,
                                Icons.account_balance),
                          const SizedBox(height: 10), // 줄 간격
                          const Divider(),

                          // 예적금 통장 목록
                          const SizedBox(height: 10), // 줄 간격
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('예적금',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              Text('8,800,000원',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 10), // 줄 간격
                          // JSON에서 불러온 예적금 계좌 표시
                          for (var account in assetModel.accounts
                              .where((acc) => acc.bankName.contains('예적금')))
                            _buildDepositAccountRow(account.bankName,
                                account.amount, Icons.account_balance),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 카드
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('카드',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '200,000원',
                                    style: const TextStyle(fontSize: 18),
                                  ), // 카드 총액
                                  Text('총 미결제 금액',
                                      style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10), // 줄 간격

                          // 신용카드 목록
                          for (var card
                              in assetModel.creditCards) // JSON에서 불러온 카드 표시
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.credit_card, size: 24),
                                    const SizedBox(width: 8),
                                    Text(card.cardName,
                                        style: const TextStyle(fontSize: 16)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text('${card.amount}원',
                                        style: const TextStyle(fontSize: 16)),
                                    Text('${card.dueDate} 결제 예정',
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.grey)),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 24),
                const SizedBox(width: 8),
                Text(bankName, style: const TextStyle(fontSize: 16)),
              ],
            ),
            Text('${amount}원', style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 20), // 줄 간격 추가
      ],
    );
  }

  Widget _buildDepositAccountRow(
      String bankName, String amount, IconData icon) {
    return Column(
      children: [
        Row(
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
            Text('${amount}원', style: const TextStyle(fontSize: 16)),
          ],
        ),
        const SizedBox(height: 20), // 줄 간격 추가
      ],
    );
  }
}
