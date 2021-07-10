import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid19_info_flutter/widget/line_chart_widget.dart';
import '../provider/diseases_sh_provider.dart' show DiseasesShProvider;

// ignore: must_be_immutable
class CovidCardWidget extends StatelessWidget {
  final String type;
  late String title;
  late String secondaryText;
  late IconData icon;
  int total = 0;
  int today = 0;
  int diff = 0;
  int yesterday = 0;

  CovidCardWidget(this.type) {
    if (this.type == "case") {
      this.title = "CASES";
      this.secondaryText = "Cases reported";
      this.icon = Icons.coronavirus_outlined;
    } else if (this.type == "death") {
      this.title = "DEATH";
      this.secondaryText = "Death reported";
      this.icon = Icons.new_releases_outlined;
    } else if (this.type == "recover") {
      this.title = "RECOVERED";
      this.secondaryText = "Recovered reported";
      this.icon = Icons.favorite_border_outlined;
    } else {
      this.title = "";
      this.secondaryText = "";
      this.icon = Icons.ac_unit;
    }
  }

  @override
  Widget build(BuildContext context) {

    final diseaseData = Provider.of<DiseasesShProvider>(context);
    final disease = diseaseData.diseaseSh;
    
    if (this.type == "case") {
      this.total = disease["today"]!.cases;
      this.today = disease["today"]!.todayCases;
      this.diff = disease["today"]!.todayCases - disease["yesterday"]!.todayCases;
      this.yesterday = disease["yesterday"]!.todayCases;
    } else if (this.type == "death") {
      this.total = disease["today"]!.deaths;
      this.today = disease["today"]!.todayDeaths;
      this.diff = disease["today"]!.todayDeaths - disease["yesterday"]!.todayDeaths;
      this.yesterday = disease["yesterday"]!.todayDeaths;
    } else if (this.type == "recover") {
      this.total = disease["today"]!.recovered;
      this.today = disease["today"]!.todayRecovered;
      this.diff = disease["today"]!.todayRecovered - disease["yesterday"]!.todayRecovered;
      this.yesterday = disease["yesterday"]!.todayRecovered;
    } else {
      this.total = 0;
      this.today = 0;
      this.diff = 0;
      this.yesterday = 0;
    }

    return Card(
      elevation: 3.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              this.icon,
              color: Theme.of(context).iconTheme.color,
            ),
            title: Text("TOTAL ${this.title}"),
            subtitle: Text(this.secondaryText),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    '${this.total}',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                    ),
                  ),
                ),
                Container(
                  width: 200.0,
                  height: 100.0,
                  child: LineChartWidget(this.type),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'TODAY ${this.title}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '${this.today}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                        RichText(
                          text: this.today != 0
                              ? TextSpan(
                                  children: [
                                    WidgetSpan(
                                      child: Text(
                                        '${this.diff} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16),
                                      ),
                                    ),
                                    WidgetSpan(
                                      child: this.diff < 0
                                          ? Icon(
                                              Icons.trending_down_outlined,
                                              size: 24,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.trending_up_outlined,
                                              size: 24,
                                              color: Colors.red,
                                            ),
                                    ),
                                  ],
                                )
                              : TextSpan(children: [
                                  WidgetSpan(child: Text("Not Ready"))
                                ]),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'All Time Trend',
                          style: TextStyle(
                            fontSize: 9,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Text(
                                  'Yesterday ',
                                ),
                              ),
                              WidgetSpan(
                                child: Text(
                                  '${this.yesterday}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
