import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:test/Data/Chart.dart';

import '../controller/SimpleController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 150,
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
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: Text(
                      "Symbol 선택",
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => GestureDetector(
                    onTap: () async {
                      await Get.find<SimpleController>().test();
                    },
                    child: Container(
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
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Text(
                        "서버 시간 : " +
                            Get.find<SimpleController>()
                                .response
                                .value
                                .serverTime
                                .toString(),
                        style: TextStyle(
                          fontSize: 30,
                        ),
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
                    color: Theme.of(context).colorScheme.primaryContainer,
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
    );
  }
}
