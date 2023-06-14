import 'dart:convert';
import 'dart:convert';

import 'package:flutter/foundation.dart';

Charts welcome1FromJson(String str) => Charts.fromJson(json.decode(str));

String welcome1ToJson(Charts data) => json.encode(data.toJson());

class Charts {
  List<List<double>> chart;
  Charts({
    required this.chart,
  });

  factory Charts.fromJson(Map<String, dynamic> json) => Charts(
        chart: List<List<double>>.from(json["chart"]
            .map((x) => List<double>.from(x.map((x) => x.toDouble())))),
      );

  Map<String, dynamic> toJson() => {
        "chart": List<dynamic>.from(
            chart.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Charts {
//   List<List<double>> chart;
//   Charts({
//     required this.chart,
//   });

//   Charts copyWith({
//     List<List<double>>? chart,
//   }) {
//     return Charts(
//       chart: chart ?? this.chart,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'chart': chart,
//     };
//   }

//   factory Charts.fromMap(Map<String, dynamic> map) {
//     return Charts(
//       chart: List<List<double>>.from((map['chart'] as List<int>).map<List<double>>((x) => x,),),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Charts.fromJson(String source) => Charts.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Charts(chart: $chart)';

//   @override
//   bool operator ==(covariant Charts other) {
//     if (identical(this, other)) return true;
  
//     return 
//       listEquals(other.chart, chart);
//   }

//   @override
//   int get hashCode => chart.hashCode;
// }
