class SalesData {
  final String customerName;
  final String customerNo;
  final int previousYearData;
  final int currentYearData;
  final int position;

  SalesData({
    required this.customerName,
    required this.customerNo,
    required this.previousYearData,
    required this.currentYearData,
    required this.position,
  });
}

final List<SalesData> dummySalesYTDData = [
  SalesData(
    customerName: 'Customer A',
    customerNo: 'C001',
    previousYearData: 200,
    currentYearData: 300,
    position: 1,
  ),
  SalesData(
    customerName: 'Customer B',
    customerNo: 'C002',
    previousYearData: 100,
    currentYearData: 150,
    position: 2,
  ),
  SalesData(
    customerName: 'Customer C',
    customerNo: 'C003',
    previousYearData: 150,
    currentYearData: 200,
    position: 3,
  ),
];

final List<SalesData> dummySalesMTDData = [
  SalesData(
    customerName: 'Customer A',
    customerNo: 'C001',
    previousYearData: 200,
    currentYearData: 300,
    position: 1,
  ),
  SalesData(
    customerName: 'Customer B',
    customerNo: 'C002',
    previousYearData: 100,
    currentYearData: 150,
    position: 2,
  ),
];
