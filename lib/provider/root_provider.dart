import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:trackc19/models/time_series.dart';

class RootProvider with ChangeNotifier {
  Map _globalData;
  var countries;
  Map test = {
    "country": "Bangladesh",
    "province": ["mainland"],
    "timeline": {
      "cases": {
        "11/16/20": 434472,
        "11/17/20": 436684,
        "11/18/20": 438795,
        "11/19/20": 441159,
        "11/20/20": 443434,
        "11/21/20": 445281,
        "11/22/20": 447341,
        "11/23/20": 449760,
        "11/24/20": 451990,
        "11/25/20": 454146
      },
      "deaths": {
        "11/16/20": 6215,
        "11/17/20": 6254,
        "11/18/20": 6275,
        "11/19/20": 6305,
        "11/20/20": 6322,
        "11/21/20": 6350,
        "11/22/20": 6388,
        "11/23/20": 6416,
        "11/24/20": 6448,
        "11/25/20": 6487
      },
      "recovered": {
        "11/16/20": 351146,
        "11/17/20": 352895,
        "11/18/20": 354788,
        "11/19/20": 356722,
        "11/20/20": 358431,
        "11/21/20": 360352,
        "11/22/20": 362428,
        "11/23/20": 364611,
        "11/24/20": 366877,
        "11/25/20": 369179
      }
    }
  };
  getStatus() async {
    if (_globalData != null) {
      return _globalData;
    } else {
      const url = 'https://disease.sh/v3/covid-19/all';
      try {
        var response =
            await http.get(url, headers: {'Accept': 'application/json'});
        _globalData = jsonDecode(response.body);
        return _globalData;
      } catch (error) {
        // print('Error from status');
        // print(error);
        throw Exception('Error fetchng data');
        // return [];
      }
    }
  }

  getCountryListWithData({String sortBy = 'cases'}) async {
    if (countries != null) {
      return countries;
    } else {
      try{
        final url = 'https://disease.sh/v3/covid-19/countries?sort=$sortBy';
        var response =
            await http.get(url, headers: {'Accept': 'application/json'});
          countries = jsonDecode(response.body);
          return countries;
      }catch(error){
        // print(error);
        throw Exception('Error fetchng data');
      }
    }
  }

  getHistoricData({String country}) async {
    final String url =
        'https://disease.sh/v3/covid-19/historical/$country?lastdays=11';
    try {
      var response = await http.get(url);
      var data = jsonDecode(response.body);
      List<TimeSeries> cases = _convertIntoList(data['timeline']['cases']);
      List<TimeSeries> deaths = _convertIntoList(data['timeline']['deaths']);
      List<TimeSeries> recovered =
          _convertIntoList(data['timeline']['recovered']);
      return {
        'country': country,
        'cases': cases,
        'deaths': deaths,
        'recovered': recovered
      };
    } catch (error) {
      // print(error);
      throw Exception('Error fetchng data');
    }
  }

  List<TimeSeries> _convertIntoList(Map history) {
    List<TimeSeries> intoTimeSeries = [];
    List<int> register = [];
    history.forEach((key, value) {
      register.add(value);
      intoTimeSeries.add(new TimeSeries(key, value));
    });
    for (int i = 1; i < register.length; i++) {
      int temp = intoTimeSeries[i].number - register[i - 1];
      intoTimeSeries[i].number = temp > 0 ? temp : 0;
      // print(intoTimeSeries[i].number);
    }
    intoTimeSeries.removeAt(0);
    return intoTimeSeries;
  }
}
