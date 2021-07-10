import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiseaseSh {
  final String country;
  final int cases;
  final int todayCases;
  final int deaths;
  final int todayDeaths;
  final int recovered;
  final int todayRecovered;
  final int casesPerOneMillion;
  final int deathsPerOneMillion;
  final int tests;
  final int testsPerOneMillion;
  final int population;
  final String continent;
  final int oneCasePerPeople;
  final int oneDeathPerPeople;
  final int oneTestPerPeople;
  final double activePerOneMillion;
  final double recoveredPerOneMillion;
  final double criticalPerOneMillion;
  final List vaccine;
  final int doses;
  final int todayDoses;
  final int fullyVacinne;
  final Map casesAllTime;
  final Map deathsAllTime;
  final Map recoversAllTime;

  DiseaseSh({
    required this.country,
    required this.cases,
    required this.todayCases,
    required this.deaths,
    required this.todayDeaths,
    required this.recovered,
    required this.todayRecovered,
    required this.casesPerOneMillion,
    required this.deathsPerOneMillion,
    required this.tests,
    required this.testsPerOneMillion,
    required this.population,
    required this.continent,
    required this.oneCasePerPeople,
    required this.oneDeathPerPeople,
    required this.oneTestPerPeople,
    required this.activePerOneMillion,
    required this.recoveredPerOneMillion,
    required this.criticalPerOneMillion,
    required this.vaccine,
    required this.doses,
    required this.todayDoses,
    required this.fullyVacinne,
    required this.casesAllTime,
    required this.deathsAllTime,
    required this.recoversAllTime,
  });
}

class DiseasesShProvider with ChangeNotifier {
  Map<String, DiseaseSh> _diseaseSh = {};

  DiseasesShProvider();

  Map<String, DiseaseSh> get diseaseSh {
    return {..._diseaseSh};
  }

  Future<void> fetchAndSet() async {
    var urlToday =
        'https://corona.lmao.ninja/v2/countries/Malaysia?yesterday&strict&query';
    var urlYesterday =
        'https://corona.lmao.ninja/v2/countries/Malaysia?yesterday=1&strict&query';
    var url2DaysAgo =
        'https://corona.lmao.ninja/v2/countries/Malaysia?twoDaysAgo=1&strict&query';
    var urlVaccine =
        'https://raw.githubusercontent.com/CITF-Malaysia/citf-public/main/vaccination/vax_malaysia.csv';
    var urlAllTime =
        'https://corona.lmao.ninja/v2/historical/Malaysia?lastdays=all';

    try {
      final responseToday = await http.get(Uri.parse(urlToday));
      final responseYesterday = await http.get(Uri.parse(urlYesterday));
      final response2DaysAgo = await http.get(Uri.parse(url2DaysAgo));
      final responseVaccine = await http.get(Uri.parse(urlVaccine));
      final responseAllTime = await http.get(Uri.parse(urlAllTime));

      final Map<String, DiseaseSh> loadedDiseaseMap = {};

      final List<dynamic> listMapVaccine = [];

      final extractedDataToday =
          json.decode(responseToday.body) as Map<String, dynamic>;
      final extractedDataYesterday =
          json.decode(responseYesterday.body) as Map<String, dynamic>;
      final extractedData2DaysAgo =
          json.decode(response2DaysAgo.body) as Map<String, dynamic>;
      final extractedAllTime =
          json.decode(responseAllTime.body) as Map<String, dynamic>;

      var mapVaccine = new Map();
      final listVaccine = responseVaccine.body.split("\n");

      listVaccine.removeAt(0);
      listVaccine.removeAt(listVaccine.length - 1);

      for (int i = 0; i < listVaccine.length; i++) {
        var values = listVaccine[i];
        var listValues = values.split(",");

        mapVaccine = {
          "date": listValues[0],
          "dose1_daily": listValues[1],
          "dose2_daily": listValues[2],
          "total_daily": listValues[3],
          "dose1_cumul": listValues[4],
          "dose2_cumul": listValues[5],
          "total_cumul": listValues[6],
        };

        listMapVaccine.add(mapVaccine);
      }

      loadedDiseaseMap["today"] = DiseaseSh(
        country: extractedDataToday['country'],
        cases: extractedDataToday['cases'],
        todayCases: extractedDataToday['todayCases'],
        deaths: extractedDataToday['deaths'],
        todayDeaths: extractedDataToday['todayDeaths'],
        recovered: extractedDataToday['recovered'],
        todayRecovered: extractedDataToday['todayRecovered'],
        casesPerOneMillion: extractedDataToday['casesPerOneMillion'],
        deathsPerOneMillion: extractedDataToday['deathsPerOneMillion'],
        tests: extractedDataToday['tests'],
        testsPerOneMillion: extractedDataToday['testsPerOneMillion'],
        population: extractedDataToday['population'],
        continent: extractedDataToday['continent'],
        oneCasePerPeople: extractedDataToday['oneCasePerPeople'],
        oneDeathPerPeople: extractedDataToday['oneDeathPerPeople'],
        oneTestPerPeople: extractedDataToday['oneTestPerPeople'],
        activePerOneMillion: extractedDataToday['activePerOneMillion'],
        recoveredPerOneMillion: extractedDataToday['recoveredPerOneMillion'],
        criticalPerOneMillion: extractedDataToday['criticalPerOneMillion'],
        vaccine: listMapVaccine,
        doses: int.parse(listMapVaccine.last["total_cumul"]),
        todayDoses: int.parse(listMapVaccine.last["total_daily"]),
        fullyVacinne: int.parse(listMapVaccine.last["dose2_cumul"]),
        casesAllTime: extractedAllTime["timeline"]["cases"],
        recoversAllTime: extractedAllTime["timeline"]["deaths"],
        deathsAllTime: extractedAllTime["timeline"]["recovered"],
      );

      loadedDiseaseMap["yesterday"] = DiseaseSh(
        country: extractedDataYesterday['country'],
        cases: extractedDataYesterday['cases'],
        todayCases: extractedDataYesterday['todayCases'],
        deaths: extractedDataYesterday['deaths'],
        todayDeaths: extractedDataYesterday['todayDeaths'],
        recovered: extractedDataYesterday['recovered'],
        todayRecovered: extractedDataYesterday['todayRecovered'],
        casesPerOneMillion: extractedDataYesterday['casesPerOneMillion'],
        deathsPerOneMillion: extractedDataYesterday['deathsPerOneMillion'],
        tests: extractedDataYesterday['tests'],
        testsPerOneMillion: extractedDataYesterday['testsPerOneMillion'],
        population: extractedDataYesterday['population'],
        continent: extractedDataYesterday['continent'],
        oneCasePerPeople: extractedDataYesterday['oneCasePerPeople'],
        oneDeathPerPeople: extractedDataYesterday['oneDeathPerPeople'],
        oneTestPerPeople: extractedDataYesterday['oneTestPerPeople'],
        activePerOneMillion: extractedDataYesterday['activePerOneMillion'],
        recoveredPerOneMillion:
            extractedDataYesterday['recoveredPerOneMillion'],
        criticalPerOneMillion: extractedDataYesterday['criticalPerOneMillion'],
        vaccine: listMapVaccine,
        doses:
            int.parse(listMapVaccine[listMapVaccine.length - 2]["total_cumul"]),
        todayDoses:
            int.parse(listMapVaccine[listMapVaccine.length - 2]["total_daily"]),
        fullyVacinne:
            int.parse(listMapVaccine[listMapVaccine.length - 2]["dose2_cumul"]),
        casesAllTime: extractedAllTime["timeline"]["cases"],
        recoversAllTime: extractedAllTime["timeline"]["deaths"],
        deathsAllTime: extractedAllTime["timeline"]["recovered"],
      );

      loadedDiseaseMap["2daysago"] = DiseaseSh(
        country: extractedData2DaysAgo['country'],
        cases: extractedData2DaysAgo['cases'],
        todayCases: extractedData2DaysAgo['todayCases'],
        deaths: extractedData2DaysAgo['deaths'],
        todayDeaths: extractedData2DaysAgo['todayDeaths'],
        recovered: extractedData2DaysAgo['recovered'],
        todayRecovered: extractedData2DaysAgo['todayRecovered'],
        casesPerOneMillion: extractedData2DaysAgo['casesPerOneMillion'],
        deathsPerOneMillion: extractedData2DaysAgo['deathsPerOneMillion'],
        tests: extractedData2DaysAgo['tests'],
        testsPerOneMillion: extractedData2DaysAgo['testsPerOneMillion'],
        population: extractedData2DaysAgo['population'],
        continent: extractedData2DaysAgo['continent'],
        oneCasePerPeople: extractedData2DaysAgo['oneCasePerPeople'],
        oneDeathPerPeople: extractedData2DaysAgo['oneDeathPerPeople'],
        oneTestPerPeople: extractedData2DaysAgo['oneTestPerPeople'],
        activePerOneMillion: extractedData2DaysAgo['activePerOneMillion'],
        recoveredPerOneMillion: extractedData2DaysAgo['recoveredPerOneMillion'],
        criticalPerOneMillion: extractedData2DaysAgo['criticalPerOneMillion'],
        vaccine: listMapVaccine,
        doses:
            int.parse(listMapVaccine[listMapVaccine.length - 3]["total_cumul"]),
        todayDoses:
            int.parse(listMapVaccine[listMapVaccine.length - 3]["total_daily"]),
        fullyVacinne:
            int.parse(listMapVaccine[listMapVaccine.length - 3]["dose2_cumul"]),
        casesAllTime: extractedAllTime["timeline"]["cases"],
        recoversAllTime: extractedAllTime["timeline"]["deaths"],
        deathsAllTime: extractedAllTime["timeline"]["recovered"],
      );

      _diseaseSh = loadedDiseaseMap;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
