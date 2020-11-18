import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RootProvider with ChangeNotifier{
    Map globalData;
    getStatus() async {
        if(globalData==null){
            const url = 'https://disease.sh/v3/covid-19/all';
            var response = await http.get(
                url,
                headers: {
                    'Accept': 'application/json'
                }
            );
            // print(response.statusCode);
            // print(response.body);
            if(response.statusCode == 200){
              globalData = jsonDecode(response.body);
              // print(globalData);
              return globalData;
            }else {
              return null;
            }
        }else{
            return globalData;
        }

    }
}