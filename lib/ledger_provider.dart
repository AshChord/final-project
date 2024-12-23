import 'package:flutter/material.dart';

class LedgerProvider with ChangeNotifier {
  double totalIncome = 0;
  double totalExpense = 0;
  List<Map<String, dynamic>> records = []; // 수입/지출 기록

  void addIncome(String description, double amount) {
    totalIncome += amount;
    records
        .add({'type': 'income', 'description': description, 'amount': amount});
    notifyListeners();
  }

  void addExpense(String description, double amount) {
    totalExpense += amount;
    records
        .add({'type': 'expense', 'description': description, 'amount': amount});
    notifyListeners();
  }
}
