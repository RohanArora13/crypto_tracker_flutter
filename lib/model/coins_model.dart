import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Coins {
  String? id;
  String? icon;
  String? name;
  String? symbol;
  dynamic? rank;
  dynamic? price;
  dynamic priceBtc;
  dynamic? volume;
  dynamic? marketCap;
  dynamic? availableSupply;
  dynamic? totalSupply;
  dynamic? priceChange1h;
  dynamic? priceChange1d;
  dynamic? priceChange1w;
  String? websiteUrl;
  String? twitterUrl;
  List<dynamic>? exp;

  Coins({
    this.id,
    this.icon,
    this.name,
    this.symbol,
    this.rank,
    this.price,
    this.priceBtc,
    this.volume,
    this.marketCap,
    this.availableSupply,
    this.totalSupply,
    this.priceChange1h,
    this.priceChange1d,
    this.priceChange1w,
    this.websiteUrl,
    this.twitterUrl,
    this.exp,
  });

  Coins copyWith({
    String? id,
    String? icon,
    String? name,
    String? symbol,
    dynamic? rank,
    dynamic? price,
    dynamic? priceBtc,
    dynamic? volume,
    dynamic? marketCap,
    dynamic? availableSupply,
    dynamic? totalSupply,
    dynamic? priceChange1h,
    dynamic? priceChange1d,
    dynamic? priceChange1w,
    String? websiteUrl,
    String? twitterUrl,
    List<dynamic>? exp,
  }) {
    return Coins(
      id: id ?? this.id,
      icon: icon ?? this.icon,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      rank: rank ?? this.rank,
      price: price ?? this.price,
      priceBtc: priceBtc ?? this.priceBtc,
      volume: volume ?? this.volume,
      marketCap: marketCap ?? this.marketCap,
      availableSupply: availableSupply ?? this.availableSupply,
      totalSupply: totalSupply ?? this.totalSupply,
      priceChange1h: priceChange1h ?? this.priceChange1h,
      priceChange1d: priceChange1d ?? this.priceChange1d,
      priceChange1w: priceChange1w ?? this.priceChange1w,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      exp: exp ?? this.exp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'icon': icon,
      'name': name,
      'symbol': symbol,
      'rank': rank,
      'price': price,
      'priceBtc': priceBtc,
      'volume': volume,
      'marketCap': marketCap,
      'availableSupply': availableSupply,
      'totalSupply': totalSupply,
      'priceChange1h': priceChange1h,
      'priceChange1d': priceChange1d,
      'priceChange1w': priceChange1w,
      'websiteUrl': websiteUrl,
      'twitterUrl': twitterUrl,
      'exp': exp,
    };
  }

  factory Coins.fromMap(Map<String, dynamic> map) {
    return Coins(
      id: map['id'] != null ? map['id'] as String : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      symbol: map['symbol'] != null ? map['symbol'] as String : null,
      rank: map['rank'] != null ? map['rank'] as dynamic : null,
      price: map['price'] != null ? map['price'] as dynamic : null,
      priceBtc: map['priceBtc'] as dynamic,
      volume: map['volume'] != null ? map['volume'] as dynamic : null,
      marketCap: map['marketCap'] != null ? map['marketCap'] as dynamic : null,
      availableSupply: map['availableSupply'] != null
          ? map['availableSupply'] as dynamic
          : null,
      totalSupply:
          map['totalSupply'] != null ? map['totalSupply'] as dynamic : null,
      priceChange1h:
          map['priceChange1h'] != null ? map['priceChange1h'] as dynamic : null,
      priceChange1d:
          map['priceChange1d'] != null ? map['priceChange1d'] as dynamic : null,
      priceChange1w:
          map['priceChange1w'] != null ? map['priceChange1w'] as dynamic : null,
      websiteUrl:
          map['websiteUrl'] != null ? map['websiteUrl'] as String : null,
      twitterUrl:
          map['twitterUrl'] != null ? map['twitterUrl'] as String : null,
      exp: map['exp'] != null
          ? List<dynamic>.from((map['exp'] as List<dynamic>))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coins.fromJson(String source) =>
      Coins.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Coins(id: $id, icon: $icon, name: $name, symbol: $symbol, rank: $rank, price: $price, priceBtc: $priceBtc, volume: $volume, marketCap: $marketCap, availableSupply: $availableSupply, totalSupply: $totalSupply, priceChange1h: $priceChange1h, priceChange1d: $priceChange1d, priceChange1w: $priceChange1w, websiteUrl: $websiteUrl, twitterUrl: $twitterUrl, exp: $exp)';
  }

  @override
  bool operator ==(covariant Coins other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.icon == icon &&
        other.name == name &&
        other.symbol == symbol &&
        other.rank == rank &&
        other.price == price &&
        other.priceBtc == priceBtc &&
        other.volume == volume &&
        other.marketCap == marketCap &&
        other.availableSupply == availableSupply &&
        other.totalSupply == totalSupply &&
        other.priceChange1h == priceChange1h &&
        other.priceChange1d == priceChange1d &&
        other.priceChange1w == priceChange1w &&
        other.websiteUrl == websiteUrl &&
        other.twitterUrl == twitterUrl &&
        listEquals(other.exp, exp);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        icon.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        rank.hashCode ^
        price.hashCode ^
        priceBtc.hashCode ^
        volume.hashCode ^
        marketCap.hashCode ^
        availableSupply.hashCode ^
        totalSupply.hashCode ^
        priceChange1h.hashCode ^
        priceChange1d.hashCode ^
        priceChange1w.hashCode ^
        websiteUrl.hashCode ^
        twitterUrl.hashCode ^
        exp.hashCode;
  }
}
