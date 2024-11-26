class ExpenseDetail {
  final String expenseType;
  final String month;
  final String financialYear;
  final String amount;

  ExpenseDetail({
    required this.expenseType,
    required this.month,
    required this.financialYear,
    required this.amount,
  });

  factory ExpenseDetail.fromJson(Map<String, dynamic> json) {
    return ExpenseDetail(
      expenseType: json['expense_type'] ?? '',
      month: json['month'] ?? '',
      financialYear: json['financial_year'] ?? '',
      amount: json['amount'] ?? '0',
    );
  }
}

class Expense {
  final int id;
  final String workplaceCode;
  final String workplaceName;
  final String employeeCode;
  final String employeeName;
  final String createdAt;
  final int status;
  final List<ExpenseDetail> details;

  Expense({
    required this.id,
    required this.workplaceCode,
    required this.workplaceName,
    required this.employeeCode,
    required this.employeeName,
    required this.createdAt,
    required this.status,
    required this.details,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      workplaceCode: json['workplace_code'] ?? '',
      workplaceName: json['workplace_name'] ?? '',
      employeeCode: json['hr_employee_code'] ?? '',
      employeeName: json['employee_name'] ?? '',
      createdAt: json['created_at'] ?? '',
      status: json['status'] ?? 0,
      details: (json['details'] as List)
          .map((item) => ExpenseDetail.fromJson(item))
          .toList(),
    );
  }
}
