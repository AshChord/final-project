import 'package:flutter/foundation.dart';

class BudgetProvider with ChangeNotifier {
  final Map<String, double> _budgets = {}; // 예산 항목 데이터
  double _savingsGoal = 0.0; // 저축 목표 금액

  // 예산 항목 관리
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

  // 저축 목표 관리
  double get savingsGoal => _savingsGoal;

  void setSavingsGoal(double amount) {
    _savingsGoal = amount;
    notifyListeners();
  }
}
