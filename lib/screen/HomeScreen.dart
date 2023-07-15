import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:test/Data/Chart.dart';
import 'package:test/controller/binanceApiController.dart';

import '../controller/SimpleController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.only(top: 30, left: 20, right: 25),
                            height: 150,
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
                            child: Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '승리 확률',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          onChanged: (text) {
                                            
                                          },
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(5),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.redAccent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.blue),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '수익률',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          onChanged: (text) {},
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(5),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.redAccent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.blue),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          '손실률',
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: TextField(
                                          textAlign: TextAlign.center,
                                          onChanged: (text) {},
                                          decoration: InputDecoration(
                                            isDense: true,
                                            contentPadding: EdgeInsets.all(5),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.redAccent),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  width: 1, color: Colors.blue),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                            ),
                                          ),
                                          keyboardType: TextInputType.number,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text('최적의 비율 ')),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 30, right: 20),
                            height: 150,
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
                                    itemCount: Get.find<BinanceApiController>()
                                        .SymbolList
                                        .length, // 항목 개수
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(Get.find<BinanceApiController>()
                                              .SymbolSelect[
                                          Get.find<BinanceApiController>()
                                              .SymbolList[index]!]!);
                                      return Obx(
                                        () => GestureDetector(
                                          onTap: () {
                                            Get.find<BinanceApiController>()
                                                .SelectSymbol(Get.find<
                                                        BinanceApiController>()
                                                    .SymbolList[index]!);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(5),
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
                                                      .tertiaryContainer
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
                                                    : Colors.white54,
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
                                                        .onTertiaryContainer
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
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
                    GestureDetector(
                      onTap: () async {},
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 40),
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
                        child: Text(
                          "서버 시간 : " +
                              Get.find<SimpleController>()
                                  .response
                                  .value
                                  .serverTime
                                  .toString(),
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: LineChart(
                            mainChart(context),
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
