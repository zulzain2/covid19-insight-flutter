import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../provider/diseases_sh_provider.dart' show DiseasesShProvider;

// ignore: must_be_immutable
class LineChartWidget extends StatefulWidget {
  final String type;
  late List<FlSpot> spots = [];

  LineChartWidget(this.type);

  @override
  State<StatefulWidget> createState() => LineChartWidgetState();
}

class LineChartWidgetState extends State<LineChartWidget> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    final diseaseData = Provider.of<DiseasesShProvider>(context);
    final disease = diseaseData.diseaseSh;

    if (this.widget.type == "case") {
      double i = 0;
      int prevValue = 0;
      int currValue = 0;
      disease["today"]!.casesAllTime.forEach((key, value) {
        if (i == 0) {
          this.widget.spots.add(FlSpot(i, value.toDouble()));
        } else {
          currValue = value - prevValue;
          this.widget.spots.add(FlSpot(i, currValue.toDouble()));
          prevValue = value;
        }
        i++;
      });
    } else if (this.widget.type == "death") {
      double i = 0;
      int prevValue = 0;
      int currValue = 0;
      disease["today"]!.deathsAllTime.forEach((key, value) {
        if (i == 0) {
          this.widget.spots.add(FlSpot(i, value.toDouble()));
        } else {
          currValue = value - prevValue;
          this.widget.spots.add(FlSpot(i, currValue.toDouble()));
          prevValue = value;
        }
        i++;
      });
    } else if (this.widget.type == "recover") {
      double i = 0;
      int prevValue = 0;
      int currValue = 0;
      disease["today"]!.recoversAllTime.forEach((key, value) {
        if (i == 0) {
          this.widget.spots.add(FlSpot(i, value.toDouble()));
        } else {
          currValue = value - prevValue;
          this.widget.spots.add(FlSpot(i, currValue.toDouble()));
          prevValue = value;
        }
        i++;
      });
    } else if (this.widget.type == "vaccine") {
      double i = 0;
      for (var item in disease["today"]!.vaccine) {
        this.widget.spots.add(FlSpot(i, double.parse(item["total_daily"])));

        i++;
      }
    } else if (this.widget.type == "test") {
      
    } else {}

    return AspectRatio(
      aspectRatio: 1.23,
      child: Container(
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                    child: LineChart(
                      sampleData1(),
                      swapAnimationDuration: const Duration(milliseconds: 250),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: false,
          // reservedSize: 22,
          // getTextStyles: (value) => const TextStyle(
          //   color: Color(0xff72719b),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 16,
          // ),
          // margin: 10,
          // getTitles: (value) {
          //   switch (value.toInt()) {
          //     case 2:
          //       return 'SEPT';
          //     case 7:
          //       return 'OCT';
          //     case 12:
          //       return 'DEC';
          //   }
          //   return '';
          // },
        ),
        leftTitles: SideTitles(
          showTitles: false,
          // getTextStyles: (value) => const TextStyle(
          //   color: Color(0xff75729e),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 14,
          // ),
          // getTitles: (value) {
          //   switch (value.toInt()) {
          //     case 1:
          //       return '1m';
          //     case 2:
          //       return '2m';
          //     case 3:
          //       return '3m';
          //     case 4:
          //       return '5m';
          //   }
          //   return '';
          // },
          // margin: 8,
          // reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Colors.transparent,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      // maxX: 20,
      // maxY: 10,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final lineChartBarData = LineChartBarData(
      spots: this.widget.spots.length != 0
          ? this.widget.spots
          : [
              FlSpot(1, 1),
              FlSpot(3, 2.8),
              FlSpot(7, 1.2),
              FlSpot(10, 2.8),
              FlSpot(12, 2.6),
              FlSpot(13, 3.9),
            ],
      isCurved: false,
      colors: const [
        Colors.blueAccent,
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        const Color(0x1d62b0e6),
      ]),
    );
    return [
      lineChartBarData,
    ];
  }
}
