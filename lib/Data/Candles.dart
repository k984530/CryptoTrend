import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../binanceObject/BinanceCandle.dart';
import '../controller/BinanceApiController.dart';

Widget Candles(BuildContext buildContext, String symbol) {
  List<Candle> test = [];
  for (BinanceCandle c
      in Get.find<BinanceApiController>().SymbolCandle[symbol]) {
    test.add(
      Candle(
        date: DateTime.fromMillisecondsSinceEpoch(c.CloseTime),
        high: double.parse(c.High),
        low: double.parse(c.Low),
        open: double.parse(c.Open),
        close: double.parse(c.Close),
        volume: double.parse(c.Volume),
      ),
    );
  }
  test = test.reversed.toList();
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(symbol),
      ),
      Expanded(
        child: Candlesticks(
          candles: test,
        ),
      ),
    ],
  );
}
