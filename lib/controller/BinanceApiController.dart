import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:test/binanceObject/SymbolInfo.dart';

class BinanceApiController extends GetxController {
  final String baseURL = 'https://fapi.binance.com';
  final String DataURL = '/fapi/v1/exchangeInfo';
  RxList SymbolList = [].obs;
  RxMap SymbolSelect = {}.obs;

  @override
  onInit() {
    super.onInit();
    GetSymbol();
  }

  Future<void> GetSymbol() async {
    final request = Uri.parse(baseURL + DataURL);
    await http.get(request).then((value) {
      SymbolInfo Info = SymbolInfo.fromJson(value.body);
      print(Info.symbols.length);
      SymbolList.value = Info.symbols.map((e) {
        print(e.symbol + e.symbol.contains("USDT").toString());
        if (e.symbol.contains("USDT")) {
          SymbolSelect[e.symbol] = false;
          return e.symbol;
        }
      }).toList();
      SymbolList.removeWhere((element) => element == null);
      print("symbolList : " + SymbolList.toString());
      print("symlen : " + SymbolList.length.toString());
      return SymbolList;
    });
  }

  SelectSymbol(String Symbol) {
    SymbolSelect[Symbol] = !SymbolSelect[Symbol];
  }
}
