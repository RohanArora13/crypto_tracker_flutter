// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'coins_model.dart';

class CoinsList {
  List<Coins>? coins;
  CoinsList({
    required this.coins,
  });

  CoinsList copyWith({
    List<Coins>? coins,
  }) {
    return CoinsList(
      coins: coins ?? this.coins,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coins': coins!.map((x) => x?.toMap()).toList(),
    };
  }

  factory CoinsList.fromMap(Map<String, dynamic> map) {
    return CoinsList(
      coins: map['coins'] != null
          ? List<Coins>.from(
              (map['coins'] as List<dynamic>).map<Coins?>(
                (x) => Coins.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoinsList.fromJson(String source) =>
      CoinsList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CoinsList(coins: $coins)';

  @override
  bool operator ==(covariant CoinsList other) {
    if (identical(this, other)) return true;

    return listEquals(other.coins, coins);
  }

  @override
  int get hashCode => coins.hashCode;
}
