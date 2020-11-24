import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackc19/screens/country_list_screen.dart';
import 'package:trackc19/widgets/single_status.dart';
import 'package:provider/provider.dart';
import 'package:trackc19/provider/root_provider.dart';

class HomeScreen extends StatelessWidget {
  static final String routeName = '/';
  @override
  Widget build(BuildContext context) {
    final rootProvider = Provider.of<RootProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Covid 19 Status'),
          actions: [
            IconButton(
              icon: Icon(Icons.list), 
              onPressed: (){
                Navigator.pushNamed(context, CountryListScreen.routeName);
              }
            )
          ],
        ),
        body: FutureBuilder(
          future: rootProvider.getStatus(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // print(snapshot.data);
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            child: Image.network(
                                'https://img.techpowerup.org/201118/stay-home-5091880-640.jpg')),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SingleStatus(
                            label: 'Total Cases',
                            amount: snapshot.data['cases'],
                            color: Colors.orangeAccent,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SingleStatus(
                            flex: 2,
                            label: 'Active Cases',
                            amount: snapshot.data['active'],
                          ),
                          SizedBox(width: 10),
                          SingleStatus(
                              flex: 2,
                              label: 'Deaths',
                              amount: snapshot.data['deaths'],
                              color: Colors.redAccent),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SingleStatus(
                            label: 'Recovered',
                            amount: snapshot.data['recovered'],
                            color: Colors.green[600],
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Today\'s status',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      Row(children: [
                        SingleStatus(
                          label: 'Today\'s cases',
                          amount:  snapshot.data['todayCases'],
                          color: Colors.orangeAccent,
                        ),
                        SizedBox(width: 10),
                        SingleStatus(
                          label: 'Today\'s death',
                          amount: snapshot.data['todayDeaths'],
                          color: Colors.redAccent,
                        ),
                      ]),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          SingleStatus(
                            label: 'Today\'s recovered',
                            amount: snapshot.data['todayRecovered'],
                            color: Colors.green[600],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }else if(snapshot.hasError){
              return Text('Error fetching data');
            }else{
              return Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ));
  }
}
