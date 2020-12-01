import 'package:flutter/material.dart';
import 'package:trackc19/provider/root_provider.dart';
import 'package:trackc19/screens/SplashScreen.dart';
import 'package:trackc19/screens/country_list_screen.dart';
import 'package:trackc19/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:trackc19/screens/single_country_data_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> RootProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        routes: {
          HomeScreen.routeName: (context)=> HomeScreen(),
          CountryListScreen.routeName: (context)=> CountryListScreen(),
          SingleCountryDataScreen.routeName: (context)=> SingleCountryDataScreen(),
        },
      ),
    );
  }
}