import 'package:crypto_tracker/common/error_dialog.dart';
import 'package:crypto_tracker/model/chart_model.dart';
import 'package:crypto_tracker/model/coin_global_avg_model.dart';
import 'package:crypto_tracker/repository/main_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';
import 'common/loader.dart';
import 'dart:async';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'dart:math';

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

  List<FlSpot> convertData(Charts chartsdata) {
    List<FlSpot> flspotList = [];
    List<List<double>> smallerList = [];
    List<List<double>> ogList = chartsdata.chart;
    if (ogList.length > 26) {
      smallerList = ogList.sublist(ogList.length - 25, ogList.length);
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
    if (ogList.length > 26) {
      smallerList = ogList.sublist(ogList.length - 25, ogList.length);
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
    List<double> values = [];
    values.add(minVal - 50);
    values.add(maxVal + 50);
    print(values);
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
                height: height * 0.25,
                width: width * 0.9,
                elevation: 0,
                color: Color.fromARGB(46, 243, 154, 251),
                padding: const EdgeInsets.all(8),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Column(
                  children: [
                    // above text row
                    aboveText("assets/BTC_Logo.svg", "Bitcoin", "BTC"),
                    CoinChartWidget(ref, "bitcoin", [
                      Color.fromARGB(255, 190, 16, 175),
                      Color.fromARGB(255, 144, 16, 133)
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CoinPriceWidget(ref, "bitcoin"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
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

  Widget CoinChartWidget(
      WidgetRef ref, String coinName, List<Color> gradientColors) {
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
              height: 100,
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
