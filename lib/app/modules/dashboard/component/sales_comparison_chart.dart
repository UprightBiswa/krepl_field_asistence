import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/sales_dara_model.dart';

class SalesComparisonChart extends StatelessWidget {
  final String title;
  final List<SelesDateLine> line;

  const SalesComparisonChart(
      {Key? key, required this.title, required this.line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: SizedBox(
        height: 300,
        child: SfCartesianChart(
            margin: const EdgeInsets.all(2.0),
            title: ChartTitle(text: title, textStyle: AppTypography.kLight12),
            legend: const Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            // series: <CartesianSeries>[
            //   ColumnSeries<SalesData, String>(
            //     dataSource: data,
            //     xValueMapper: (SalesData sales, _) => sales.category,
            //     yValueMapper: (SalesData sales, _) => sales.current,
            //     name: 'Current',
            //     color: Colors.blue, // Color for the current bar
            //   ),
            //   ColumnSeries<SalesData, String>(
            //     dataSource: data,
            //     xValueMapper: (SalesData sales, _) => sales.category,
            //     yValueMapper: (SalesData sales, _) => sales.target,
            //     name: 'Target',
            //     color: Colors.green, // Color for the target bar
            //   ),
            //   ColumnSeries<SalesData, String>(
            //     dataSource: data,
            //     xValueMapper: (SalesData sales, _) => sales.category,
            //     yValueMapper: (SalesData sales, _) => sales.lastYear,
            //     name: 'Last Year',
            //     color: Colors.orange, // Color for the last year bar
            //   ),
            // ],
            primaryXAxis: const CategoryAxis(
              title: AxisTitle(text: 'Sales'),
            ),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'Sales'),
            ),
            series: <CartesianSeries<SelesDateLine, String>>[
              LineSeries<SelesDateLine, String>(
                dataSource:line,
                pointColorMapper: (SelesDateLine line, _) => line.color,
                xValueMapper: (SelesDateLine line, _) => line.year,
                yValueMapper: (SelesDateLine line, _) => line.sales,
                dataLabelSettings: const DataLabelSettings(isVisible: true),
              )
            ]),
      ),
    );
  }
}
