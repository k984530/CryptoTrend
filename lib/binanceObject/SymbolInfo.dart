// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:collection/collection.dart';

class SymbolInfo {
  List exchangeFilters;
  List<LateLimit> rateLimits;
  int serverTime;
  List<Asset> assets;
  List<Symbol> symbols;

  SymbolInfo({
    required this.exchangeFilters,
    required this.rateLimits,
    required this.serverTime,
    required this.assets,
    required this.symbols,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exchangeFilters': exchangeFilters,
      'rateLimits': rateLimits.map((x) => x.toMap()).toList(),
      'serverTime': serverTime,
      'assets': assets.map((x) => x.toMap()).toList(),
      'symbols': symbols.map((x) => x.toMap()).toList(),
    };
  }

  factory SymbolInfo.fromMap(Map<String, dynamic> map) {
    return SymbolInfo(
      exchangeFilters: List.from(map['exchangeFilters'] as List),
      rateLimits: List<LateLimit>.from(
        (map['rateLimits']).map<LateLimit>(
          (x) => LateLimit.fromMap(x as Map<String, dynamic>),
        ),
      ),
      serverTime: map['serverTime'] as int,
      assets: List<Asset>.from(
        (map['assets']).map<Asset>(
          (x) => Asset.fromMap(x as Map<String, dynamic>),
        ),
      ),
      symbols: List<Symbol>.from(
        (map['symbols']).map<Symbol>(
          (x) => Symbol.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SymbolInfo.fromJson(String source) =>
      SymbolInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  SymbolInfo copyWith({
    List? exchangeFilters,
    List<LateLimit>? rateLimits,
    int? serverTime,
    List<Asset>? assets,
    List<Symbol>? symbols,
  }) {
    return SymbolInfo(
      exchangeFilters: exchangeFilters ?? this.exchangeFilters,
      rateLimits: rateLimits ?? this.rateLimits,
      serverTime: serverTime ?? this.serverTime,
      assets: assets ?? this.assets,
      symbols: symbols ?? this.symbols,
    );
  }

  @override
  String toString() {
    return 'SymbolInfo(exchangeFilters: $exchangeFilters, rateLimits: $rateLimits, serverTime: $serverTime, assets: $assets, symbols: $symbols)';
  }

  @override
  bool operator ==(covariant SymbolInfo other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.exchangeFilters, exchangeFilters) &&
        listEquals(other.rateLimits, rateLimits) &&
        other.serverTime == serverTime &&
        listEquals(other.assets, assets) &&
        listEquals(other.symbols, symbols);
  }

  @override
  int get hashCode {
    return exchangeFilters.hashCode ^
        rateLimits.hashCode ^
        serverTime.hashCode ^
        assets.hashCode ^
        symbols.hashCode;
  }
}

class Symbol {
  String symbol;
  Symbol({
    required this.symbol,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'symbol': symbol,
    };
  }

  factory Symbol.fromMap(Map<String, dynamic> map) {
    return Symbol(
      symbol: map['symbol'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Symbol.fromJson(String source) =>
      Symbol.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Filter {
  String filterType;
  int maxPrice;
  double minPrice;
  double tickSize;
  Filter({
    required this.filterType,
    required this.maxPrice,
    required this.minPrice,
    required this.tickSize,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'filterType': filterType,
      'maxPrice': maxPrice,
      'minPrice': minPrice,
      'tickSize': tickSize,
    };
  }

  factory Filter.fromMap(Map<String, dynamic> map) {
    return Filter(
      filterType: map['filterType'] as String,
      maxPrice: map['maxPrice'] as int,
      minPrice: map['minPrice'] as double,
      tickSize: map['tickSize'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Filter.fromJson(String source) =>
      Filter.fromMap(json.decode(source) as Map<String, dynamic>);

  Filter copyWith({
    String? filterType,
    int? maxPrice,
    double? minPrice,
    double? tickSize,
  }) {
    return Filter(
      filterType: filterType ?? this.filterType,
      maxPrice: maxPrice ?? this.maxPrice,
      minPrice: minPrice ?? this.minPrice,
      tickSize: tickSize ?? this.tickSize,
    );
  }

  @override
  String toString() {
    return 'Filter(filterType: $filterType, maxPrice: $maxPrice, minPrice: $minPrice, tickSize: $tickSize)';
  }

  @override
  bool operator ==(covariant Filter other) {
    if (identical(this, other)) return true;

    return other.filterType == filterType &&
        other.maxPrice == maxPrice &&
        other.minPrice == minPrice &&
        other.tickSize == tickSize;
  }

  @override
  int get hashCode {
    return filterType.hashCode ^
        maxPrice.hashCode ^
        minPrice.hashCode ^
        tickSize.hashCode;
  }
}

class Asset {
  String asset;
  bool marginAvailable;
  String autoAssetExchange;
  Asset({
    required this.asset,
    required this.marginAvailable,
    required this.autoAssetExchange,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'asset': asset,
      'marginAvailable': marginAvailable,
      'autoAssetExchange': autoAssetExchange,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      asset: map['asset'] as String,
      marginAvailable: map['marginAvailable'] as bool,
      autoAssetExchange: map['autoAssetExchange'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Asset.fromJson(String source) =>
      Asset.fromMap(json.decode(source) as Map<String, dynamic>);

  Asset copyWith({
    String? asset,
    bool? marginAvailable,
    String? autoAssetExchange,
  }) {
    return Asset(
      asset: asset ?? this.asset,
      marginAvailable: marginAvailable ?? this.marginAvailable,
      autoAssetExchange: autoAssetExchange ?? this.autoAssetExchange,
    );
  }

  @override
  String toString() =>
      'Asset(asset: $asset, marginAvailable: $marginAvailable, autoAssetExchange: $autoAssetExchange)';

  @override
  bool operator ==(covariant Asset other) {
    if (identical(this, other)) return true;

    return other.asset == asset &&
        other.marginAvailable == marginAvailable &&
        other.autoAssetExchange == autoAssetExchange;
  }

  @override
  int get hashCode =>
      asset.hashCode ^ marginAvailable.hashCode ^ autoAssetExchange.hashCode;
}

class LateLimit {
  String interval;
  int intervalNum;
  int limit;
  LateLimit({
    required this.interval,
    required this.intervalNum,
    required this.limit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'interval': interval,
      'intervalNum': intervalNum,
      'limit': limit,
    };
  }

  factory LateLimit.fromMap(Map<String, dynamic> map) {
    return LateLimit(
      interval: map['interval'] as String,
      intervalNum: map['intervalNum'] as int,
      limit: map['limit'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory LateLimit.fromJson(String source) =>
      LateLimit.fromMap(json.decode(source) as Map<String, dynamic>);

  LateLimit copyWith({
    String? interval,
    int? intervalNum,
    int? limit,
  }) {
    return LateLimit(
      interval: interval ?? this.interval,
      intervalNum: intervalNum ?? this.intervalNum,
      limit: limit ?? this.limit,
    );
  }

  @override
  String toString() =>
      'LateLimit(interval: $interval, intervalNum: $intervalNum, limit: $limit)';

  @override
  bool operator ==(covariant LateLimit other) {
    if (identical(this, other)) return true;

    return other.interval == interval &&
        other.intervalNum == intervalNum &&
        other.limit == limit;
  }

  @override
  int get hashCode => interval.hashCode ^ intervalNum.hashCode ^ limit.hashCode;
}
