import 'dart:convert';

import 'package:crypto_tracker/model/chart_model.dart';
import 'package:crypto_tracker/model/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:crypto_tracker/constants.dart';

import '../model/coin_global_avg_model.dart';

final MainRepositoryProvider =
    Provider((Ref) => MainRepository(client: Client()));

class MainRepository {
  final Client _client;

  MainRepository({required client}) : _client = client;

  Future<DataModel> getCoinInfo(String coinName) async {
    DataModel data = DataModel(error: "something went wrong", data: null);
    try {
      print('$host/coins/$coinName?currency=USD');
      var res = await _client.get(
        Uri.parse('$host/coins/$coinName?currency=USD'),
        // headers: {
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
      );
      print("res.body =" + res.body.toString());
      print("res.statusCode =" + res.statusCode.toString());
      switch (res.statusCode) {
        case 200:
          CoinGlobal coinData = CoinGlobal.fromJson(res.body.toString());
          print(res.body);
          data = DataModel(
            error: null,
            data: coinData,
          );
          break;
        case 404:
          data = DataModel(
            error: res.body,
            data: null,
          );
          break;
        default:
          data = DataModel(
            error: res.body,
            data: null,
          );
          break;
      }
      print(data.error.toString());
    } catch (e) {
      print(e.toString());
      data = DataModel(error: e.toString(), data: null);
    }
    return data;
  }

  Future<DataModel> getChartInfo(String coinName) async {
    DataModel data = DataModel(error: "something went wrong", data: null);
    try {
      print('$host/coins/$coinName?currency=USD');
      var res = await _client.get(
        Uri.parse('$host/charts?period=24h&coinId=$coinName'),
        // headers: {
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
      );
      print("res.body =" + res.body.toString());
      print("res.statusCode =" + res.statusCode.toString());
      switch (res.statusCode) {
        case 200:
          final Map<String, dynamic> parsed = json.decode(res.body);
          Charts chartData = Charts.fromJson(parsed);
          print(res.body);
          data = DataModel(
            error: null,
            data: chartData,
          );
          break;
        case 404:
          data = DataModel(
            error: res.body,
            data: null,
          );
          break;
        default:
          data = DataModel(
            error: res.body,
            data: null,
          );
          break;
      }
      print(data.error.toString());
    } catch (e) {
      print(e.toString());
      data = DataModel(error: e.toString(), data: null);
    }
    return data;
  }
}
