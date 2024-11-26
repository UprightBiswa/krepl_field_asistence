class ExpenseType {
  final int id;
  final String expenseType;

  ExpenseType({required this.id, required this.expenseType});

  factory ExpenseType.fromJson(Map<String, dynamic> json) {
    return ExpenseType(
      id: json['id'],
      expenseType: json['expense_type'],
    );
  }
}
