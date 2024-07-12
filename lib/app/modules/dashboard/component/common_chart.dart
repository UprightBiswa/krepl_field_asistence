import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/piedata_model.dart';

class CommonChart extends StatelessWidget {
  final List<PieData> data;
  final String title;

  const CommonChart({
    Key? key,
    required this.data,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: SizedBox(
        height: 200,
        child: SfCircularChart(
          margin: const EdgeInsets.all(2.0),
          title: ChartTitle(text: title, textStyle: AppTypography.kLight12),
          legend: const Legend(isVisible: true),
          series: <PieSeries<PieData, String>>[
            PieSeries<PieData, String>(
              explode: true,
              explodeIndex: 0,
              dataSource: data,
              xValueMapper: (PieData data, _) => data.xData,
              yValueMapper: (PieData data, _) => data.yData,
              dataLabelMapper: (PieData data, _) => data.text,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
      ),
    );
  }
}
