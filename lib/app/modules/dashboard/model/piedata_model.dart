class PieData {
  PieData(
    this.xData,
    this.yData,
    this.text,
  );
  final String xData;
  final num yData;
  final String text;
}

final List<PieData> odPieData = [
  PieData('Current', 67290, '60%'),
  PieData('Target', 25324, '25%'),
  PieData('LY', 15324, '15%'),
];

final List<PieData> osPieData = [
  PieData('Current', 50, '50%'),
  PieData('Target', 30, '30%'),
  PieData('LY', 20, '20%'),
];

final List<PieData> salePieData = [
  PieData('Current', 40, '40%'),
  PieData('Target', 35, '35%'),
  PieData('LY', 25, '25%'),
];

final List<PieData> collPieData = [
  PieData('Current', 45, '45%'),
  PieData('Target', 30, '30%'),
  PieData('LY', 25, '25%'),
];

final List<PieData> expPieData = [
  PieData('Current', 55, '55%'),
  PieData('Target', 25, '25%'),
  PieData('LY', 20, '20%'),
];

final List<PieData> soRtPieData = [
  PieData('Current', 60, '60%'),
  PieData('Target', 25, '25%'),
  PieData('LY', 15, '15%'),
];

final List<PieData> seRtPieData = [
  PieData('Current', 70, '70%'),
  PieData('Target', 20, '20%'),
  PieData('LY', 10, '10%'),
];
