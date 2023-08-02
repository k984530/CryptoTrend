import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../binanceObject/BinanceCandle.dart';
import '../binanceObject/SymbolInfo.dart';
import '../data/DataList.dart';

class BinanceApiController extends GetxController {
  final String baseURL = 'https://fapi.binance.com';
  final String DataURL = '/fapi/v1/exchangeInfo';
  final String CandleURL = "/fapi/v1/klines";
  int point = 2400;
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
        SymbolSelect.value = jsonDecode(value.getString('SymbolSelect') ?? '');
        interval.value = returnTime(value.getString('Interval') ?? "5m");
      } catch (e) {}
      GetSymbol().then((_) {
        for (String symbol in SymbolSelect.keys) {
          if (SymbolSelect[symbol]) {
            GetCandle(symbol, interval.value).then(
              (value) async {
                GetRecentTrend(symbol);
                await FindSymbolsWithAmplitude();
              },
            );
          }
        }
      });
      Timer.periodic(
        Duration(seconds: 2),
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
      Timer.periodic(
        Duration(minutes: 1),
        (_) async {
          point = 2300;
        },
      );

      Timer.periodic(
        Duration(minutes: 5),
        (_) async {
          await FindSymbolsWithAmplitude();
        },
      );
    });
  }

  Future<bool> FindSymbolsWithAmplitude() async {
    List<String> symbolsWithAmplitude = [];
    bool findFlag = false;
    for (String symbol in SymbolList) {
      List<BinanceCandle>? candleList =
          SymbolCandle[symbol]?.cast<BinanceCandle>();
      point -= 1;
      GetCandle(symbol, IntervalTime.m5).then(
        (value) {
          if (candleList != null && candleList.isNotEmpty) {
            // 최근 1분(현재 봉)의 종가와 이전 1분(이전 봉)의 종가를 가져옵니다.
            double high = double.parse(candleList[candleList.length - 2].High);
            double low = double.parse(candleList[candleList.length - 2].Low);

            // 변동폭 계산 (Amplitude 계산)
            double amplitude = ((high - low) / low).abs() * 100;
            print(amplitude);
            // 변동폭이 1%를 넘는 경우 해당 심볼을 결과 리스트에 추가하고, 해당 Symbol은 SymbolSelect에서 true로 변경합니다.
            if (amplitude > 1.0) {
              symbolsWithAmplitude.add(symbol);
              SymbolSelect[symbol] = true;
              findFlag = true;
              print("symbol : ${symbol} , amplitude : ${amplitude}");
              Get.closeAllSnackbars();
              Get.snackbar('CryptoCoin', '변동률이 큰 암호화폐가 감지되었습니다.');
            }
          }
        },
      );
    }
    return findFlag;
  }

  Future<void> GetSymbol() async {
    final request = Uri.parse(baseURL + DataURL);
    if (point > 0) {
      point -= 1;
      await http.get(request).then(
        (value) {
          SymbolInfo Info = SymbolInfo.fromJson(value.body);
          SymbolList.value = Info.symbols.map((e) {
            SymbolSelect[e.symbol] = SymbolSelect[e.symbol] ?? false;
            return e.symbol;
          }).toList();
          SymbolList.removeWhere((element) =>
              element == null || !element.toString().contains('USDT'));
          SymbolList.sort();
          return SymbolList;
        },
      );
    }
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
    int count = 0;
    if (SymbolSelect[symbol] != null && SymbolSelect[symbol]) {
      SymbolChangeRatio.remove(symbol);
    }
    for (bool v in SymbolSelect.values) {
      if (v) {
        count++;
      }
    }
    if (symbol != '' && SymbolSelect[symbol]) {
      SymbolSelect[symbol] = false;
    } else if (symbol != '' && count < 19 && !SymbolSelect[symbol]) {
      SymbolSelect[symbol] = true;
    }
    if (count < 20) {
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
          value.setString('SymbolSelect', jsonEncode(SymbolSelect));
        },
      );
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
    if (point > 0) {
      point -= 1;
      List<BinanceCandle> CandleList = [];
      await http.get(request).then(
        (value) {
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

          if (CandleList.any((element) =>
              double.parse(element.Volume) > 0.01 ||
              double.parse(element.Volume) < -0.01)) {
            SymbolCandle[symbol] = CandleList;
          } else {
            SymbolList.remove(symbol);
            SymbolSelect.remove(symbol);
          }
        },
      );
    }
  }

  GetRecentTrend(String symbol) {
    final candleList = SymbolCandle[symbol] as List<BinanceCandle>;

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
