import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/binanceObject/BinanceCandle.dart';
import 'package:test/binanceObject/SymbolInfo.dart';

import '../data/DataList.dart';

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
  onInit() async {
    super.onInit();
    SharedPreferences.getInstance().then((value) {
      try {
        print(jsonDecode(value.getString('SymbolSelect') ?? ''));
        SymbolSelect.value = jsonDecode(value.getString('SymbolSelect') ?? '');
        interval.value = returnTime(value.getString('Interval') ?? "5m");
      } catch (e) {}
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
    });
  }

  Future<void> GetSymbol() async {
    final request = Uri.parse(baseURL + DataURL);
    await http.get(request).then((value) {
      SymbolInfo Info = SymbolInfo.fromJson(value.body);
      SymbolList.value = Info.symbols.map((e) {
        if (e.symbol.contains("USDT")) {
          SymbolSelect[e.symbol] = SymbolSelect[e.symbol] ?? false;
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
    SharedPreferences.getInstance().then(
      (value) {
        value.setString('Interval', t.time);
      },
    );
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
    SharedPreferences.getInstance().then(
      (value) {
        value.setString('SymbolSelect', jsonEncode(SymbolSelect.value));
      },
    );
  }

  Future<void> GetCandle(String symbol, IntervalTime interval) async {
    final request = Uri.parse(baseURL +
        CandleURL +
        "?symbol=" +
        symbol +
        "&interval=" +
        interval.time +
        "&limit=20");
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
    final candleList = SymbolCandle[symbol] as List<BinanceCandle>;

    // ChangeRatio를 계산하려면 적어도 2개 이상의 캔들 데이터가 필요합니다.
    // 따라서 첫 번째 캔들 데이터는 무시하고, 두 번째부터 시작합니다.
    // 이렇게 하면 각 캔들 데이터에 대한 이전 캔들 데이터에 접근할 수 있습니다.
    List<double> changeRatioList = candleList.skip(1).map((candle) {
      int index = candleList.indexOf(candle);
      double previousClose = double.parse(candleList[index - 1].Close);
      double currentClose = double.parse(candle.Close);
      double changeRatio = (currentClose - previousClose) / previousClose * 100;

      // 각 캔들에 대한 ChangeRatio를 리스트에 추가합니다.
      return changeRatio;
    }).toList();

    SymbolChangeRatio[symbol] = changeRatioList;
  }
}
