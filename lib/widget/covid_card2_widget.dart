import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid19_info_flutter/widget/line_chart_widget.dart';
import '../provider/diseases_sh_provider.dart' show DiseasesShProvider;

// ignore: must_be_immutable
class CovidCard2Widget extends StatelessWidget {
  final String type;
  late String mainTitle;
  late String title1;
  late String title2;
  late String title3;
  late IconData iconMain;
  late IconData icon1;
  late IconData icon2;
  late IconData icon3;
  int total = 0;
  int today = 0;
  int diff = 0;
  int yesterday = 0;
  int lastRow = 0;

  CovidCard2Widget(this.type) {
    if (this.type == "vaccine") {
      this.mainTitle = "National COVID-19 Immunisation Programme (PICK)";
      this.title1 = "TOTAL DOSES GIVEN";
      this.title2 = "DAILY DOSES GIVEN";
      this.title3 = "PEOPLE FULLY VACCINATED";
      this.iconMain = Icons.health_and_safety_outlined;
      this.icon1 = Icons.invert_colors_outlined;
      this.icon2 = Icons.event_available_outlined;
      this.icon3 = Icons.security_outlined;
    } else if (this.type == "test") {
      this.mainTitle = "TEST";
      this.title1 = "TOTAL TEST";
      this.title2 = "TODAY TEST";
      this.title3 = "ONE TEST PER PEOPLE";
      this.iconMain = Icons.health_and_safety_outlined;
      this.icon1 = Icons.invert_colors_outlined;
      this.icon2 = Icons.event_available_outlined;
      this.icon3 = Icons.security_outlined;
    } else {
      this.mainTitle = "";
      this.title1 = "";
      this.title2 = "";
      this.title3 = "";
      this.iconMain = Icons.help_outline_outlined;
      this.icon1 = Icons.help_outline_outlined;
      this.icon2 = Icons.help_outline_outlined;
      this.icon3 = Icons.help_outline_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final diseaseData = Provider.of<DiseasesShProvider>(context);
    final disease = diseaseData.diseaseSh;

    if (this.type == "vaccine") {
      this.total = disease["today"]!.doses;
      this.today = disease["today"]!.todayDoses;
      this.diff =
          disease["today"]!.todayDoses - disease["yesterday"]!.todayDoses;
      this.yesterday = disease["yesterday"]!.todayDoses;
      this.lastRow = disease["today"]!.fullyVacinne;
    } else if (this.type == "test") {
      this.total = disease["today"]!.tests;
      this.today = disease["today"]!.testsPerOneMillion;
      this.diff = (disease["today"]!.tests - disease["yesterday"]!.tests) -
          (disease["yesterday"]!.tests - disease["2daysago"]!.tests);
      this.yesterday = disease["today"]!.tests - disease["yesterday"]!.tests;
      this.lastRow = disease["today"]!.oneTestPerPeople;
    } else {
      this.total = 0;
      this.today = 0;
      this.diff = 0;
      this.yesterday = 0;
      this.lastRow = 0;
    }

    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 30),
            child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth < 660) {
                  print(constraints.maxWidth);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: contentWidget(context),
                  );
                } else {
                  print(constraints.maxWidth);
                  return Container(
                    height:240,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: contentWidget(context),
                    ),
                  );
                }
              }),
            
          ),
        ],
      ),
    );
  }

  List<Widget> contentWidget(BuildContext context) {
    return [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.title1,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Icon(
            this.icon1,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${this.total}',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.title2,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${this.yesterday == 0 ? 0 : this.today}',
            style: this.yesterday == 0
                ? TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  )
                : TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
          ),
          this.type == "vaccine"
              ? Container(
                  width: 200.0,
                  height: 100.0,
                  child: LineChartWidget(this.type),
                )
              : SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Text(
                        '${this.diff} ',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    WidgetSpan(
                      child: this.diff < 0
                          ? Icon(
                              Icons.trending_down_outlined,
                              size: 14,
                              color: Colors.red,
                            )
                          : Icon(
                              Icons.trending_up_outlined,
                              size: 14,
                              color: Colors.green,
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  Text(
                    'Day Before',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    '${this.yesterday == 0 ? this.today : this.yesterday}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            this.title3,
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Icon(
            this.icon3,
            color: Theme.of(context).iconTheme.color,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            '${this.lastRow}',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          ),
        ],
      ),
    ];
  }
}
