import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../binanceObject/BinanceCandle.dart';
import '../controller/BinanceApiController.dart';

Widget Chart(BuildContext context, String symbol) {
  // 해당 심볼에 대한 캔들 데이터 가져오기
  List<BinanceCandle> candleDataList = Get.find<BinanceApiController>()
      .SymbolCandle[symbol] as List<BinanceCandle>;
  List<double> candleChangeList =
      Get.find<BinanceApiController>().SymbolChangeRatio[symbol];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(symbol),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: 15,
          ),
          child: LineChart(
            LineChartData(
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 0,
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ],
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                drawHorizontalLine: true,
                horizontalInterval:
                    candleChangeList.reduce(max) / 3, // 수평 라인 간격 설정
                verticalInterval: 10.0, // 수직 라인 간격 설정
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: Colors.grey,
                    strokeWidth: 0.5,
                  );
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 25,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 55,
                    interval: candleChangeList.reduce(max) / 2,
                    getTitlesWidget: (value, meta) {
                      if (value == candleChangeList.reduce(min) * 1.3 ||
                          value == candleChangeList.reduce(max) * 1.3) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 0,
                          child: Text(''),
                        );
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 5,
                        child: Text(value.toStringAsFixed(2)),
                      );
                    },
                  ),
                ),
                topTitles: AxisTitles(
                  drawBelowEverything: false,
                ),
                rightTitles: AxisTitles(
                  drawBelowEverything: false,
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  left: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  right: BorderSide(
                    color: Colors.transparent,
                  ),
                  top: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              minX: 0, // X 축의 최소값
              maxX: candleDataList.length.toDouble() - 1, // X 축의 최대값
              minY: candleChangeList.reduce(min) * 1.3,
              maxY: candleChangeList.reduce(max) * 1.3,
              lineBarsData: [
                LineChartBarData(
                  spots: candleChangeList.asMap().entries.map((entry) {
                    int index = entry.key;
                    double value = entry.value;

                    return FlSpot(
                        index.toDouble(), (value * 1000).floor() / 1000);
                  }).toList(),
                  isCurved: true, // 곡선 라인 여부
                  color: Colors.blue, // 라인 색상 설정
                  barWidth: 2.0, // 라인 두께 설정
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: false, // 데이터 점 표시 여부
                  ),
                  belowBarData: BarAreaData(
                    show: false, // 라인 아래 영역 표시 여부
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
