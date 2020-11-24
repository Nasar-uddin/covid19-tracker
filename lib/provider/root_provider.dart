import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RootProvider with ChangeNotifier {
  Map globalData;
  var countries;
  getStatus() async {
    if (globalData != null) {
      return globalData;
    } else {
      const url = 'https://disease.sh/v3/covid-19/all';
      var response =
          await http.get(url, headers: {'Accept': 'application/json'});
      print('Requested');
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        globalData = jsonDecode(response.body);
        // print(globalData);
        return globalData;
      } else {
        return null;
      }
    }
  }
  getCountryListWithData() async {
    if (countries != null) {
      // print(countries);
      return countries;
    } else {
      const url = 'https://disease.sh/v3/covid-19/countries?sort=cases';
      var response =
          await http.get(url, headers: {'Accept': 'application/json'});
      // print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        countries = jsonDecode(response.body);
        // print('Dam');
        return countries;
      } else {
        return null;
      }
    }
  }
}
