// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:crypto_tracker/model/coin_model.dart';

class CoinGlobal {
  Coin? coin;
  CoinGlobal({
    this.coin,
  });

  CoinGlobal copyWith({
    Coin? coin,
  }) {
    return CoinGlobal(
      coin: coin ?? this.coin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coin': coin?.toMap(),
    };
  }

  factory CoinGlobal.fromMap(Map<String, dynamic> map) {
    return CoinGlobal(
      coin: map['coin'] != null
          ? Coin.fromMap(map['coin'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinGlobal.fromJson(String source) =>
      CoinGlobal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CoinGlobal(coin: $coin)';

  @override
  bool operator ==(covariant CoinGlobal other) {
    if (identical(this, other)) return true;

    return other.coin == coin;
  }

  @override
  int get hashCode => coin.hashCode;
}
