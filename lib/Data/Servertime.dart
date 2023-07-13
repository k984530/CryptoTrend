// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ServerTime {
  int _serverTime;

  int get serverTime => _serverTime;

  set serverTime(int value) {
    _serverTime = value;
  }

  ServerTime({
    required int serverTime,
  }) : _serverTime = serverTime;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serverTime': serverTime,
    };
  }

  factory ServerTime.fromMap(Map<String, dynamic> map) {
    return ServerTime(
      serverTime: map['serverTime'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerTime.fromJson(String source) =>
      ServerTime.fromMap(json.decode(source) as Map<String, dynamic>);

  ServerTime copyWith({
    int? serverTime,
  }) {
    return ServerTime(
      serverTime: serverTime ?? this.serverTime,
    );
  }

  @override
  String toString() => 'ServerTime(serverTime: $serverTime)';

  @override
  bool operator ==(covariant ServerTime other) {
    if (identical(this, other)) return true;

    return other.serverTime == serverTime;
  }

  @override
  int get hashCode => serverTime.hashCode;
}
