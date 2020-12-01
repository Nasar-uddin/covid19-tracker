import 'package:flutter/material.dart';
import 'package:trackc19/screens/single_country_data_screen.dart';

class CountryList extends StatelessWidget {
  final countries;
  CountryList({this.countries});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: countries.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ListTile(
                onTap: (){
                  // print('Dam');
                  Navigator.pushNamed(
                    context, 
                    SingleCountryDataScreen.routeName,
                    arguments: countries[index]
                  );
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(countries[index]['countryInfo']['flag']),
                ),
                title: Text(
                  countries[index]['country'],
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: Text(
                  '${countries[index]["cases"]}',
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ),
            ),
          );
        });
  }
}
