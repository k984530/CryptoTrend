import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test/binanceObject/SymbolInfo.dart';

class BinanceApiController extends GetxController {
  final String baseURL = 'https://fapi.binance.com';
  final String DataURL = '/fapi/v1/exchangeInfo';

  Future<void> GetSymbol() async {
    final request = Uri.parse(baseURL + DataURL);
    await http.get(request).then((value) {
      SymbolInfo Info = SymbolInfo.fromJson(value.body);
      print(Info.symbols.length);
      List<String?> symbolList = Info.symbols.map((e) {
        print(e.symbol + e.symbol.contains("USDT").toString());
        if (e.symbol.contains("USDT")) {
          return "\"" + e.symbol + "\"";
        }
      }).toList();
      symbolList.removeWhere((element) => element == null);
      print("symbolList : " + symbolList.toString());
      print("symlen : " + symbolList.length.toString());
      return symbolList;
    });
  }
}
