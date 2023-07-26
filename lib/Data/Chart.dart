import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../binanceObject/BinanceCandle.dart';
import '../controller/BinanceApiController.dart';
import '../data/DataList.dart';

Widget Chart(BuildContext context, String symbol) {
  // 해당 심볼에 대한 캔들 데이터 가져오기
  List<BinanceCandle> candleDataList = Get.find<BinanceApiController>()
      .SymbolCandle[symbol] as List<BinanceCandle>;
  List<double> candleChangeList =
      Get.find<BinanceApiController>().SymbolChangeRatio[symbol];
  IntervalTime time = Get.find<BinanceApiController>().interval.value;
  candleChangeList = candleChangeList.reversed.toList();
  candleDataList = candleDataList.reversed.toList();
  if (candleDataList.length > 20) {
    candleDataList = candleDataList.getRange(0, 20).toList();
    candleChangeList = candleChangeList.getRange(0, 20).toList();
    candleChangeList = candleChangeList.reversed.toList();
    candleDataList = candleDataList.reversed.toList();
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(symbol),
      ),
      Expanded(
        child: Container(
          margin: EdgeInsets.only(
            right: 35,
          ),
          child: LineChart(
            LineChartData(
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: 0,
                    color: Colors.white60,
                    strokeWidth: 2,
                  ),
                ],
              ),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                drawHorizontalLine: true,
                horizontalInterval: (candleChangeList.reduce(max)).abs() >
                        (candleChangeList.reduce(min)).abs()
                    ? candleChangeList.reduce(max) / 3
                    : (candleChangeList.reduce(min)).abs() / 3, // 수평 라인 간격 설정
                verticalInterval: candleDataList.length / 4, // 수직 라인 간격 설정
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
                    interval: candleDataList.length / 2,
                    getTitlesWidget: (value, meta) {
                      String t = '';
                      if (time == IntervalTime.m1) {
                        t = DateFormat('HH:mm').format(
                          DateTime.now().add(
                            Duration(
                              minutes:
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.m3) {
                        t = DateFormat('HH:mm').format(
                          DateTime.now().add(
                            Duration(
                              minutes: 3 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.m5) {
                        t = DateFormat('HH:mm').format(
                          DateTime.now().add(
                            Duration(
                              minutes: 5 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.m15) {
                        t = DateFormat('HH:mm').format(
                          DateTime.now().add(
                            Duration(
                              minutes: 15 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.m30) {
                        t = DateFormat('HH:mm').format(
                          DateTime.now().add(
                            Duration(
                              minutes: 30 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.h1) {
                        t = DateFormat("dd'D' H'h'").format(
                          DateTime.now().add(
                            Duration(
                              hours: (value.floor() - 98),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.h2) {
                        t = DateFormat("dd'D' H'h'").format(
                          DateTime.now().add(
                            Duration(
                              hours: 2 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.h4) {
                        t = DateFormat("dd'D' H'h'").format(
                          DateTime.now().add(
                            Duration(
                              hours: 4 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.h6) {
                        t = DateFormat("dd'D' H'h'").format(
                          DateTime.now().add(
                            Duration(
                              hours: 6 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.h8) {
                        t = DateFormat("dd'D' H'h'").format(
                          DateTime.now().add(
                            Duration(
                              hours: 8 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.h12) {
                        t = DateFormat("dd'D' H'h'").format(
                          DateTime.now().add(
                            Duration(
                              hours: 12 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.d1) {
                        t = DateFormat('MM.dd').format(
                          DateTime.now().add(
                            Duration(
                              days: (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.d3) {
                        t = DateFormat('MM.dd').format(
                          DateTime.now().add(
                            Duration(
                              days: 3 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.w1) {
                        t = DateFormat('MM.dd').format(
                          DateTime.now().add(
                            Duration(
                              days: 7 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      } else if (time == IntervalTime.M1) {
                        t = DateFormat('yyyy.MM').format(
                          DateTime.now().add(
                            Duration(
                              days: 30 *
                                  (value.floor() - candleDataList.length - 1),
                            ),
                          ),
                        );
                      }
                      return SideTitleWidget(
                          child: Text(
                            t,
                          ),
                          space: 5,
                          axisSide: meta.axisSide);
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 55,
                    interval: (candleChangeList.reduce(max)).abs() >
                            (candleChangeList.reduce(min)).abs()
                        ? candleChangeList.reduce(max) / 3
                        : (candleChangeList.reduce(min)).abs() / 3,
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
                  color: Theme.of(context).colorScheme.primary, // 라인 색상 설정
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
