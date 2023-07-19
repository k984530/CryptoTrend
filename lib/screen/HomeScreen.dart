import 'package:fl_chart/fl_chart.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:test/data/Chart.dart';
import 'package:test/data/DataList.dart';
import 'package:test/binanceObject/BinanceCandle.dart';
import 'package:test/controller/BinanceApiController.dart';
import 'package:test/controller/KellyBet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(KellyBet());
    Get.put(BinanceApiController());
    final Size size = MediaQuery.of(context).size;
    final surfaceContainer = Color.fromARGB(
        Theme.of(context).colorScheme.surface.alpha,
        Theme.of(context).colorScheme.surface.red * 2,
        Theme.of(context).colorScheme.surface.green * 2,
        Theme.of(context).colorScheme.surface.blue * 2);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            Get.focusScope!.unfocus();
          },
          child: SafeArea(
            child: Center(
              child: Obx(
                () => Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 250,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(top: 30, left: 20, right: 25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    offset: Offset(10, 10),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: surfaceContainer,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  print('test');
                                },
                                child: Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 45,
                                        child: Center(
                                          child: Text(
                                            "Kelly Bet",
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '승리 확률 :',
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: SizedBox(
                                              width: 50,
                                              child: TextField(
                                                textAlign: TextAlign.center,
                                                onChanged: (text) {
                                                  Get.find<KellyBet>()
                                                          .winRate
                                                          .value =
                                                      double.parse(text) / 100;
                                                  Get.find<KellyBet>()
                                                          .lossRate
                                                          .value =
                                                      1 -
                                                          double.parse(text) /
                                                              100;
                                                  Get.find<KellyBet>()
                                                      .calculate();
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  isDense: true,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "%",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '수익률 :',
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              onChanged: (text) {
                                                Get.find<KellyBet>()
                                                        .profit
                                                        .value =
                                                    double.parse(text) / 100;

                                                Get.find<KellyBet>()
                                                    .calculate();
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                isDense: true,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "%",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              '손실률 :',
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              onChanged: (text) {
                                                Get.find<KellyBet>()
                                                        .loss
                                                        .value =
                                                    double.parse(text) / 100;
                                                Get.find<KellyBet>()
                                                    .calculate();
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                isDense: true,
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Text(
                                              "%",
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Text(
                                          '최적의 비율 ' +
                                              (Get.find<KellyBet>()
                                                          .result
                                                          .value *
                                                      100)
                                                  .toStringAsFixed(2) +
                                              " % ",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          '100번 : ' +
                                              (Get.find<KellyBet>()
                                                      .expectResult
                                                      .value)
                                                  .toStringAsFixed(2) +
                                              " x",
                                          style: TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(top: 30, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.shadow,
                                    offset: Offset(10, 10),
                                    blurRadius: 10,
                                  ),
                                ],
                                color: surfaceContainer,
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: ListView.builder(
                                      itemCount:
                                          Get.find<BinanceApiController>()
                                              .SymbolList
                                              .length, // 항목 개수
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Obx(
                                          () => GestureDetector(
                                            onTap: () {
                                              Get.find<BinanceApiController>()
                                                  .SelectSymbol(Get.find<
                                                          BinanceApiController>()
                                                      .SymbolList[index]!);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 8),
                                              padding: EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Get.find<
                                                            BinanceApiController>()
                                                        .SymbolSelect[Get.find<
                                                            BinanceApiController>()
                                                        .SymbolList[index]!]!
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .tertiaryContainer
                                                        .withOpacity(0),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                  color: Get.find<
                                                              BinanceApiController>()
                                                          .SymbolSelect[Get.find<
                                                              BinanceApiController>()
                                                          .SymbolList[index]!]!
                                                      ? Colors.black
                                                          .withOpacity(0)
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .outline,
                                                ),
                                              ),
                                              child: Text(
                                                Get.find<BinanceApiController>()
                                                    .SymbolList[index]!,
                                                style: TextStyle(
                                                  color: Get.find<
                                                              BinanceApiController>()
                                                          .SymbolSelect[Get.find<
                                                              BinanceApiController>()
                                                          .SymbolList[index]!]!
                                                      ? Theme.of(context)
                                                          .colorScheme
                                                          .onPrimaryContainer
                                                      : Theme.of(context)
                                                          .colorScheme
                                                          .outline,
                                                ),
                                              ), // 각 항목의 텍스트
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      width: size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: IntervalTime.values.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () => GestureDetector(
                              onTap: () {
                                Get.find<BinanceApiController>()
                                    .SelectInterval(IntervalTime.values[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 25,
                                  horizontal: 5,
                                ),
                                height: 50,
                                width: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Theme.of(context).colorScheme.shadow,
                                      offset: Offset(10, 10),
                                      blurRadius: 10,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(5),
                                  color: Get.find<BinanceApiController>()
                                              .interval
                                              .value ==
                                          IntervalTime.values[index]
                                      ? Theme.of(context)
                                          .colorScheme
                                          .primaryContainer
                                      : surfaceContainer,
                                ),
                                child: Text(
                                  IntervalTime.values[index].time,
                                  style: TextStyle(
                                      color: Get.find<BinanceApiController>()
                                                  .interval
                                                  .value ==
                                              IntervalTime.values[index]
                                          ? Theme.of(context)
                                              .colorScheme
                                              .onSecondaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .outline),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {},
                      child: Container(
                        height: 300,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.shadow,
                              offset: Offset(10, 10),
                              blurRadius: 10,
                            ),
                          ],
                          color: surfaceContainer,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, top: 15),
                          child: ListView.builder(
                            itemCount: Get.find<BinanceApiController>()
                                .SymbolChangeRatio
                                .length,
                            itemBuilder: (context, index) {
                              return Obx(
                                () {
                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text:
                                                Get.find<BinanceApiController>()
                                                    .SymbolChangeRatio
                                                    .keys
                                                    .toList()[index]),
                                        TextSpan(
                                          text: " : ",
                                        ),
                                        TextSpan(
                                          text: Get.find<BinanceApiController>()
                                              .SymbolChangeRatio
                                              .values
                                              .toList()[index]
                                              .last
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                            color:
                                                Get.find<BinanceApiController>()
                                                            .SymbolChangeRatio
                                                            .values
                                                            .toList()[index]
                                                            .last >
                                                        0
                                                    ? Colors.green
                                                    : Colors.red,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "% Volume : " +
                                              // Get.find<BinanceApiController>()
                                              //     .SymbolCandle[Get.find<
                                              //             BinanceApiController>()
                                              //         .SymbolChangeRatio
                                              //         .keys
                                              //         .toList()[index]]
                                              //     .Volume,
                                              Get.find<BinanceApiController>()
                                                  .SymbolCandle[Get.find<
                                                          BinanceApiController>()
                                                      .SymbolChangeRatio
                                                      .keys
                                                      .toList()[index]]
                                                  .last
                                                  .Volume,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    for (String symbol in Get.find<BinanceApiController>()
                        .SymbolChangeRatio
                        .keys
                        .toList())
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 200,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.shadow,
                                offset: Offset(10, 10),
                                blurRadius: 10,
                              ),
                            ],
                            color: surfaceContainer,
                          ),
                          child: Center(
                            child: Chart(
                              context,
                              symbol,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
