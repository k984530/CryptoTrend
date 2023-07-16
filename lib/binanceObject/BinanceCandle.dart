// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BinanceCandle {
  int OpenTime;
  String Open;
  String High;
  String Low;
  String Close;
  String Volume;
  int CloseTime;
  String QuoteAssetVolume;
  int NumberOfTrades;
  String TakerBuyBaseAssetVolume;
  String TakerBuyQuoteAssetVolume;
  String Ignore;
  BinanceCandle({
    required this.OpenTime,
    required this.Open,
    required this.High,
    required this.Low,
    required this.Close,
    required this.Volume,
    required this.CloseTime,
    required this.QuoteAssetVolume,
    required this.NumberOfTrades,
    required this.TakerBuyBaseAssetVolume,
    required this.TakerBuyQuoteAssetVolume,
    required this.Ignore,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'OpenTime': OpenTime,
      'Open': Open,
      'High': High,
      'Low': Low,
      'Close': Close,
      'Volume': Volume,
      'CloseTime': CloseTime,
      'QuoteAssetVolume': QuoteAssetVolume,
      'NumberOfTrades': NumberOfTrades,
      'TakerBuyBaseAssetVolume': TakerBuyBaseAssetVolume,
      'TakerBuyQuoteAssetVolume': TakerBuyQuoteAssetVolume,
      'Ignore': Ignore,
    };
  }

  factory BinanceCandle.fromMap(Map<String, dynamic> map) {
    return BinanceCandle(
      OpenTime: map['OpenTime'] as int,
      Open: map['Open'] as String,
      High: map['High'] as String,
      Low: map['Low'] as String,
      Close: map['Close'] as String,
      Volume: map['Volume'] as String,
      CloseTime: map['CloseTime'] as int,
      QuoteAssetVolume: map['QuoteAssetVolume'] as String,
      NumberOfTrades: map['NumberOfTrades'] as int,
      TakerBuyBaseAssetVolume: map['TakerBuyBaseAssetVolume'] as String,
      TakerBuyQuoteAssetVolume: map['TakerBuyQuoteAssetVolume'] as String,
      Ignore: map['Ignore'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BinanceCandle.fromJson(String source) =>
      BinanceCandle.fromMap(json.decode(source) as Map<String, dynamic>);
}
