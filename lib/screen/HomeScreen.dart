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
        child: SafeArea(
          child: Center(
            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10),
                    height: 150,
                    width: 200,
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
                          flex: 1,
                          child: Center(
                            child: Container(
                              child: Text(
                                "Symbol Select",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListView.builder(
                            itemCount: Get.find<BinanceApiController>()
                                .SymbolList
                                .length, // 항목 개수
                            itemBuilder: (BuildContext context, int index) {
                              print(
                                  Get.find<BinanceApiController>().SymbolSelect[
                                      Get.find<BinanceApiController>()
                                          .SymbolList[index]!]!);
                              return Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    Get.find<BinanceApiController>()
                                        .SelectSymbol(
                                            Get.find<BinanceApiController>()
                                                .SymbolList[index]!);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Get.find<BinanceApiController>()
                                                  .SymbolSelect[
                                              Get.find<BinanceApiController>()
                                                  .SymbolList[index]!]!
                                          ? Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer
                                              .withOpacity(0),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                        color: Get.find<BinanceApiController>()
                                                    .SymbolSelect[
                                                Get.find<BinanceApiController>()
                                                    .SymbolList[index]!]!
                                            ? Colors.black.withOpacity(0)
                                            : Colors.white54,
                                      ),
                                    ),
                                    child: Text(
                                      Get.find<BinanceApiController>()
                                          .SymbolList[index]!,
                                      style: TextStyle(
                                        color: Get.find<BinanceApiController>()
                                                    .SymbolSelect[
                                                Get.find<BinanceApiController>()
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
                  GestureDetector(
                    onTap: () async {
                      await Get.find<BinanceApiController>().GetSymbol();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 40),
                      height: 300,
                      width: size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Theme.of(context).colorScheme.shadow,
                        //     offset: Offset(10, 10),
                        //     blurRadius: 10,
                        //   ),
                        // ],
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
    );
  }
}
