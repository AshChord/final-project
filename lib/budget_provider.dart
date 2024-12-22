import 'package:flutter/material.dart';

class BudgetProvider with ChangeNotifier {
  final Map<String, double> _budgets = {};

  Map<String, double> get budgets => _budgets;

  // 예산 추가 및 수정
  void addBudget(String category, double amount) {
    _budgets[category] = amount;
    notifyListeners();
  }

  // 카테고리 삭제
  void removeCategory(String category) {
    _budgets.remove(category);
    notifyListeners();
  }
}
