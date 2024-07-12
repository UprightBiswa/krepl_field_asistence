class ExpenseData {
  ExpenseData(
    this.category,
    this.current,
    this.target,
    this.lastYear,
  );
  final String category;
  final double current;
  final double target;
  final double lastYear;
}

final List<ExpenseData> ytdExpenseDataList = [
  ExpenseData('Expense YTD', 7000.0, 10000.0, 15000.0),
];

final List<ExpenseData> mtdExpenseDataList = [
  ExpenseData('Expense MTD', 6000.0, 5000.0, 7500.0),
];
