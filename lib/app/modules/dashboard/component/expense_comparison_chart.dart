import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/expense_data_model.dart';

class ExpenseComparisonChart extends StatelessWidget {
  final String title;
  final List<ExpenseData> data;

  const ExpenseComparisonChart({
    super.key,
    required this.title,
    required this.data,
  });

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
          series: <CartesianSeries>[
            ColumnSeries<ExpenseData, String>(
              dataSource: data,
              xValueMapper: (ExpenseData expense, _) => expense.category,
              yValueMapper: (ExpenseData expense, _) => expense.current,
              name: 'Current',
              color: Colors.blue, // Color for the current bar
            ),
            ColumnSeries<ExpenseData, String>(
              dataSource: data,
              xValueMapper: (ExpenseData expense, _) => expense.category,
              yValueMapper: (ExpenseData expense, _) => expense.target,
              name: 'Target',
              color: Colors.green, // Color for the target bar
            ),
            ColumnSeries<ExpenseData, String>(
              dataSource: data,
              xValueMapper: (ExpenseData expense, _) => expense.category,
              yValueMapper: (ExpenseData expense, _) => expense.lastYear,
              name: 'Last Year',
              color: Colors.orange, // Color for the last year bar
            ),
          ],
          primaryXAxis: const CategoryAxis(
            title: AxisTitle(text: 'Expenses'),
          ),
          primaryYAxis: const NumericAxis(
            title: AxisTitle(text: 'Expenses'),
          ),
        ),
      ),
    );
  }
}
