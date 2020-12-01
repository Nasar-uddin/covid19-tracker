import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:trackc19/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool hasConnection;
  @override
  void initState() async {
    super.initState();
    // Timer(Duration(seconds: 5), () {
    //   Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    // });
    hasConnection = await _checkConnection();
    if(hasConnection){
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }else{
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Covid 19 status',
              style: Theme.of(context).textTheme.headline3.copyWith(
                    color: Colors.redAccent,
                  ),
            ),
          ],
        ),
        SizedBox(height: 20),
      ],
    )));
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }else{
        return false;
      }
    } on SocketException catch (_) {
      print('not connected');
      return false;
    }
  }
}
