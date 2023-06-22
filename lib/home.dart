import 'package:crypto_tracker/common/error_dialog.dart';
import 'package:crypto_tracker/model/chart_model.dart';
import 'package:crypto_tracker/model/coin_global_avg_model.dart';
import 'package:crypto_tracker/model/coin_list_model.dart';
import 'package:crypto_tracker/repository/main_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'common/loader.dart';
import 'dart:async';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'dart:math';

import 'model/coin_model.dart';
import 'model/coins_model.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    // every 60 sec refresh the build and price
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) => setState(() {}));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  int shortLength = 20;

  List<FlSpot> convertData(Charts chartsdata) {
    List<FlSpot> flspotList = [];
    List<List<double>> smallerList = [];
    List<List<double>> ogList = chartsdata.chart;
    if (ogList.length > shortLength) {
      smallerList = ogList.sublist(ogList.length - shortLength, ogList.length);
      //print(smallerList);
    } else {
      smallerList = ogList;
    }
    print("ogList.length = " + smallerList.length.toString());

    //List<List<double>> halfList = ogList.sublist();
    for (int i = 0; i < smallerList.length; i++) {
      //print("for loop");
      List<double> data = smallerList[i];
      //print(data[1]);
      flspotList.add(FlSpot(i.toDouble(), data[1]));
      //print(flspotList);
    }
    return flspotList;
  }

  List<double> chartMinMax(Charts chartsdata) {
    List<List<double>> smallerList = [];
    List<List<double>> ogList = chartsdata.chart;
    if (ogList.length > shortLength) {
      smallerList = ogList.sublist(ogList.length - shortLength, ogList.length);
      //print(smallerList);
    } else {
      smallerList = ogList;
    }

    //print("ogList.length = " + smallerList.length.toString());
    //List<List<double>> halfList = ogList.sublist();
    List<double> allValues = [];
    for (int i = 0; i < smallerList.length; i++) {
      //print("for loop");
      List<double> data = smallerList[i];
      allValues.add(data[1]);
    }

    double minVal = allValues.reduce(min);
    double maxVal = allValues.reduce(max);

    //print("ogList.length = " + smallerList.length.toString());
    //List<List<double>> halfList = ogList.sublist();

    //print("minVal = " + minVal.toString());
    //print("maxVal = " + maxVal.toString());
    double precentage = (maxVal * (0.2 / 100));
    //print("percentage" + precentage.toString());
    List<double> values = [];
    values.add(minVal - precentage);
    values.add(maxVal + precentage);
    // print(values);
    return values;
  }

  String addComma(String price) {
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String Function(Match) mathFunc = (Match match) => '${match[1]},';
    return price.replaceAllMapped(reg, mathFunc);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final List<Color> gradientColors = [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
    ];
    return SafeArea(
        child: ScaffoldGradientBackground(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color.fromARGB(255, 12, 10, 48),
          Color.fromARGB(255, 7, 6, 40),
        ],
      ),
      // body: BackdropFilter(
      //   filter: ImageFilter.blur(sigmaX: 500.0, sigmaY: 500.0),
      //   child:
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              //Image.asset("assets/beverages.png"),
              // Container(
              //     width: 50,
              //     height: 50,
              //     decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //
              //      color: Color.fromARGB(205, 120, 14, 152))),

              Positioned(
                right: 30,
                bottom: 10,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.3,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        //center: Alignment(-0.8, -0.6),
                        colors: [
                          Color.fromRGBO(164, 8, 175, 0.503),
                          Color.fromARGB(95, 61, 2, 72)
                        ],
                        radius: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 50),
                      ],
                    ),
                    // child: const Image(
                    //   image: AssetImage(
                    //     'lib/assets/images/main_background.jpg',
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),

              BlurryContainer(
                blur: 20,
                height: height * 0.23,
                width: width * 0.9,
                elevation: 0,
                color: Color.fromARGB(46, 243, 154, 251),
                padding: const EdgeInsets.all(8),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Column(
                  children: [
                    // above text row
                    aboveText("assets/BTC_Logo.svg", "Bitcoin", "BTC"),
                    CoinChartWidget(
                        ref,
                        "bitcoin",
                        [
                          Color.fromARGB(255, 131, 13, 121),
                          Color.fromARGB(255, 227, 15, 210)
                        ],
                        height),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CoinPriceWidget(ref, "bitcoin"),
                    )
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          // ethereum
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 30,
                bottom: 10,
                child: Opacity(
                  opacity: 1,
                  child: Container(
                    width: width * 0.3,
                    height: height * 0.3,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        //center: Alignment(-0.8, -0.6),
                        colors: [
                          Color.fromRGBO(8, 28, 175, 0.502),
                          Color.fromARGB(95, 6, 2, 72)
                        ],
                        radius: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(blurRadius: 50),
                      ],
                    ),
                    // child: const Image(
                    //   image: AssetImage(
                    //     'lib/assets/images/main_background.jpg',
                    //   ),
                    //   fit: BoxFit.cover,
                    // ),
                  ),
                ),
              ),
              BlurryContainer(
                blur: 20,
                height: height * 0.23,
                width: width * 0.9,
                elevation: 0,
                color: Color.fromARGB(45, 154, 156, 251),
                padding: const EdgeInsets.all(8),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Column(
                  children: [
                    // above text row
                    aboveText("assets/eth_Logo.svg", "Ethereum", "ETH"),
                    CoinChartWidget(
                        ref,
                        "ethereum",
                        [
                          Color.fromARGB(255, 10, 100, 122),
                          Color.fromARGB(255, 13, 191, 235)
                        ],
                        height),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CoinPriceWidget(ref, "ethereum"),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Top 15 Crypto",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FutureBuilder(
              future: ref.watch(MainRepositoryProvider).getCoinsList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                if (snapshot.data!.error != null) {
                  Future.delayed(
                      Duration.zero,
                      () => _showDialog(
                          context, snapshot.data!.error.toString()));
                  return Text(
                    snapshot.data!.error.toString(),
                    style: TextStyle(color: Colors.white),
                  );
                } else if (snapshot.data!.data != null) {
                  CoinsList coinsList = snapshot.data!.data;
                  return SingleChildScrollView(
                    child: Container(
                      height: height * 0.4,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: coinsList.coins!.length,
                          itemBuilder: (context, index) {
                            Coins coin = coinsList.coins![index];
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 1, 10, 1),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      aboveTextNetworkImage(
                                          coin.icon.toString(),
                                          coin.name.toString(),
                                          coin.symbol.toString()),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "\$" +
                                                addComma(coin.price!
                                                    .toStringAsFixed(2)),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            coin.priceChange1h!
                                                    .toStringAsFixed(2) +
                                                "%",
                                            style: TextStyle(
                                                color: coin.priceChange1h!
                                                        .toDouble()
                                                        .isNegative
                                                    ? Colors.red
                                                    : Colors.green,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w200),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Color.fromARGB(141, 133, 133, 133),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  );
                } else {
                  return const Center(child: Text("some error occured"));
                }
              }),
        ],
      ),
    ));
  }

  Widget aboveTextNetworkImage(String imgName, String H1, String H2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: Image.network(imgName),
          ),
          SizedBox(
            width: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                H1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                H2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w200),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget aboveText(String imgName, String H1, String H2) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            child: SvgPicture.asset(imgName, semanticsLabel: 'Acme Logo'),
          ),
          SizedBox(
            width: 7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                H1,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                H2,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w200),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget CoinChartWidget(WidgetRef ref, String coinName,
      List<Color> gradientColors, double height) {
    return FutureBuilder(
        future: ref.watch(MainRepositoryProvider).getChartInfo(coinName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.data!.error != null) {
            Future.delayed(Duration.zero,
                () => _showDialog(context, snapshot.data!.error.toString()));
            return Text(snapshot.data!.error.toString());
          } else if (snapshot.data!.data != null) {
            Charts chartData = snapshot.data!.data;
            List<FlSpot> spot_data = convertData(chartData);
            List<double> minMaxVal = chartMinMax(chartData);

            return Center(
                child: Container(
              height: height * 0.1,
              width: 300,
              child: LineChart(LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: spot_data.length.toDouble(),
                  minY: minMaxVal[0],
                  maxY: minMaxVal[1],
                  titlesData: FlTitlesData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      belowBarData: BarAreaData(show: false),
                      aboveBarData: BarAreaData(show: false),
                      spots: spot_data,
                      isCurved: true,
                      gradient: LinearGradient(colors: gradientColors),
                      barWidth: 5,
                      isStrokeCapRound: false,
                      dotData: FlDotData(
                        show: false,
                      ),
                    )
                  ])),
            ));
          } else {
            return const Center(child: Text("some error occured"));
          }
        });
  }

  Widget CoinPriceWidget(WidgetRef ref, String coinName) {
    return FutureBuilder(
        future: ref.watch(MainRepositoryProvider).getCoinInfo(coinName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.data!.error != null) {
            Future.delayed(Duration.zero,
                () => _showDialog(context, snapshot.data!.error.toString()));
            return Text(snapshot.data!.error.toString());
          } else if (snapshot.data!.data != null) {
            CoinGlobal coinGlobal = snapshot.data!.data;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$" + addComma(coinGlobal.coin!.price!.toStringAsFixed(2)),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  coinGlobal.coin!.priceChange1h!.toStringAsFixed(2) + "%",
                  style: TextStyle(
                      color:
                          coinGlobal.coin!.priceChange1h!.toDouble().isNegative
                              ? Colors.red
                              : Colors.green,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                )
              ],
            );
          } else {
            return const Center(child: Text("some error occured"));
          }
        });
  }

  _showDialog(BuildContext context, String errorText) {
    continueCallBack() => {
          Navigator.of(context).pop(),
          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog("Error", errorText, continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
