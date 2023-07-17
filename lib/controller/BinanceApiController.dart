import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:test/binanceObject/BinanceCandle.dart';
import 'package:test/binanceObject/SymbolInfo.dart';

import '../Data/DataList.dart';

class BinanceApiController extends GetxController {
  final String baseURL = 'https://fapi.binance.com';
  final String DataURL = '/fapi/v1/exchangeInfo';
  final String CandleURL = "/fapi/v1/klines";
  RxMap SymbolRatio = {}.obs;
  Rx<IntervalTime> interval = IntervalTime.m5.obs;
  RxList SymbolList = [].obs;
  RxMap SymbolSelect = {}.obs;
  RxMap SymbolCandle = {}.obs;
  RxMap SymbolChangeRatio = {}.obs;

  @override
  onInit() {
    super.onInit();
    GetSymbol();
    Timer.periodic(
      Duration(seconds: 5),
      (_) {
        for (String symbol in SymbolSelect.keys) {
          if (SymbolSelect[symbol]) {
            GetCandle(symbol, interval.value).then(
              (value) {
                GetRecentTrend(symbol);
              },
            );
          }
        }
      },
    );
  }

  Future<void> GetSymbol() async {
    final request = Uri.parse(baseURL + DataURL);
    await http.get(request).then((value) {
      SymbolInfo Info = SymbolInfo.fromJson(value.body);
      SymbolList.value = Info.symbols.map((e) {
        if (e.symbol.contains("USDT")) {
          SymbolSelect[e.symbol] = false;
          return e.symbol;
        }
      }).toList();
      SymbolList.removeWhere((element) => element == null);
      return SymbolList;
    });
  }

  SelectInterval(IntervalTime t) async {
    interval.value = t;
    await SelectSymbol('');
  }

  SelectSymbol(String symbol) async {
    if (symbol != '') {
      SymbolSelect[symbol] = !SymbolSelect[symbol];
    }

    if (SymbolSelect[symbol] != null && !SymbolSelect[symbol]) {
      SymbolChangeRatio.remove(symbol);
    }

    for (String symbol2 in SymbolSelect.keys) {
      if (SymbolSelect[symbol2]) {
        GetCandle(symbol2, interval.value).then(
          (value) {
            GetRecentTrend(symbol2);
          },
        );
      }
    }
  }

  Future<void> GetCandle(String symbol, IntervalTime interval) async {
    final request = Uri.parse(baseURL +
        CandleURL +
        "?symbol=" +
        symbol +
        "&interval=" +
        interval.time +
        "&limit=99");
    List<BinanceCandle> CandleList = [];
    await http.get(request).then((value) {
      for (List l1 in jsonDecode(value.body)) {
        final candle = BinanceCandle(
            OpenTime: l1[0],
            Open: l1[1],
            High: l1[2],
            Low: l1[3],
            Close: l1[4],
            Volume: l1[5],
            CloseTime: l1[6],
            QuoteAssetVolume: l1[7],
            NumberOfTrades: l1[8],
            TakerBuyBaseAssetVolume: l1[9],
            TakerBuyQuoteAssetVolume: l1[10],
            Ignore: l1[11]);
        CandleList.add(candle);
      }
      SymbolCandle[symbol] = CandleList;
    });
  }

  GetRecentTrend(String symbol) {
    final candle = SymbolCandle[symbol] as List<BinanceCandle>;
    double ChangeRatio = (double.parse(candle.last.Close) -
            double.parse(candle[candle.length - 2].Close)) /
        double.parse(candle[candle.length - 2].Close) *
        100;
    SymbolChangeRatio[symbol] = ChangeRatio;
  }
}
