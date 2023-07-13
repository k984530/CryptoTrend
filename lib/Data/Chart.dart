import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

LineChartData mainChart(BuildContext context) {
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: true,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: Theme.of(context).colorScheme.onPrimaryContainer,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: const FlTitlesData(
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      show: false,
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(
            color: Theme.of(context).colorScheme.onPrimaryContainer, width: 1)),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        spots: [
          FlSpot(0, 3),
          FlSpot(2.6, 2),
          FlSpot(4.9, 5),
          FlSpot(6.8, 3.1),
          FlSpot(8, 4),
          FlSpot(9.5, 3),
          FlSpot(11, 4),
        ],
        isCurved: true,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
        ),
        belowBarData: BarAreaData(
          show: true,
        ),
      ),
    ],
  );
}
