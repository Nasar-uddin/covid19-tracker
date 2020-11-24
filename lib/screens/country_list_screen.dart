import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trackc19/provider/root_provider.dart';
import 'package:trackc19/widgets/country_list.dart';

class CountryListScreen extends StatelessWidget {
  static final String routeName = '/country_list';

  @override
  Widget build(BuildContext context) {
    final rootProvider = Provider.of<RootProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Affected countries'),
        ),
        body: FutureBuilder(
          future: rootProvider.getCountryListWithData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(snapshot.data);
            if(snapshot.hasData){
              return Container(
                padding: EdgeInsets.all(12), 
                child: CountryList(countries: snapshot.data)
              );
            }else if(snapshot.hasError){
              return Center(
                child: Text('Error loading data'),
              );
            }else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
