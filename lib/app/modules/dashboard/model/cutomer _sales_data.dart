class SalesData {
  final String customerName;
  final String customerNo;
  final int previousYearData;
  final int currentYearData;

  SalesData({
    required this.customerName,
    required this.customerNo,
    required this.previousYearData,
    required this.currentYearData,
  });
}

final List<SalesData> dummySalesYTDData = [
  SalesData(
    customerName: 'Customer A customer customer name',
    customerNo: 'C001',
    previousYearData: 200,
    currentYearData: 300,
  ),
  SalesData(
    customerName: 'Customer B',
    customerNo: 'C002',
    previousYearData: 100,
    currentYearData: 150,
  ),
];

final List<SalesData> dummySalesMTDData = [
  SalesData(
    customerName: 'Customer A',
    customerNo: 'C001',
    previousYearData: 200,
    currentYearData: 300,
  ),
  SalesData(
    customerName: 'Customer B',
    customerNo: 'C002',
    previousYearData: 100,
    currentYearData: 150,
  ),
];
